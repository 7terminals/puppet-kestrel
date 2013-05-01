# Class: kestrel
#
# The Kestrel module allows Puppet to install, configure and maintain the Kestrel server.
#
# Parameters: ensure, source, deploymentdir, user
#
# Sample Usage:
#    kestrel::setup { 'example.com-kestrel':
#      ensure        => 'present',
#      source        => 'kestrel-2.4.1.zip',
#      deploymentdir => '/home/example.com/apps/kestrel',
#      user          => 'example.com'
#    }
class kestrel {

}
