kestrel::setup { 'kestrel':
  ensure        => 'present',
  source        => 'kestrel-2.4.1.zip',
  deploymentdir => '/home/jude/kestrel',
  user          => 'jude'
}