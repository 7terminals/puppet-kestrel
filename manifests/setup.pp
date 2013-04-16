define kestrel::setup (
  $source        = undef,
  $deploymentdir = undef,
  $user          = undef,
  $cachedir      = "/var/run/puppet/working-kestrel-${name}",
  $ensure        = 'present') {
  # we support only Debian and RedHat
  case $::osfamily {
    Debian  : { $supported = true }
    RedHat  : { $supported = true }
    default : { fail("The ${module_name} module is not supported on ${::osfamily} based systems") }
  }

  # parameter validation
  if ($source == undef) {
    fail('source parameter must be set')
  }

  if ($deploymentdir == undef) {
    fail('deployment parameter must be set')
  }

  if ($user == undef) {
    fail('user parameter must be set')
  }

  if !($ensure in ['absent', 'present']) {
    fail('ensure parameter must be either absent or present')
  }
  

  if ($caller_module_name == undef) {
    $mod_name = $module_name
  } else {
    $mod_name = $caller_module_name
  }

  if ($ensure == 'present') {
    # working directory to unzip kestrel
    file { $cachedir:
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '644',
    }

    # resource defaults for Exec
    Exec {
      path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'],
    }

    file { "${cachedir}/${source}":
      source  => "puppet:///modules/${mod_name}/${source}",
      require => File[$cachedir],
    }

    exec { "extract_kestrel-${name}":
      cwd     => $cachedir,
      command => "mkdir extracted; unzip -d extracted ${source} && touch .kestrel_extracted",
      creates => "${cachedir}/.kestrel_extracted",
      require => File["${cachedir}/${source}"],
    }

    exec { "create_target_kestrel-${name}":
      cwd     => '/',
      command => "mkdir -p ${deploymentdir}",
      creates => $deploymentdir,
      require => Exec["extract_kestrel-${name}"],
    }

    exec { "move_kestrel-${name}":
      cwd     => $cachedir,
      command => "cp -r extracted/kestrel*/* ${deploymentdir} && chown -R ${user}:${user} ${deploymentdir}",
      creates => "${deploymentdir}/config/production.scala",
      require => Exec["create_target_kestrel-${name}"],
    }
  } else {
    file { $deploymentdir:
      ensure  => 'absent',
      recurse => true,
      force   => true,
    }
  }
}
