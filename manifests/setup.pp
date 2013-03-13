define kestrel::setup (
  $source        = undef,
  $deploymentdir = undef,
  $user          = undef,
  $cachedir      = "/var/run/puppet/working-kestrel-${name}") {
  # working directory to unzip kestrel
  file { $cachedir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '644',
  }

  # resource defaults for Exec
  Exec {
    path => ['/sbin', '/bin', '/usr/sbin', '/usr/bin'], }

  file { "${cachedir}/${source}":
    source  => "puppet:///modules/${caller_module_name}/${source}",
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
}