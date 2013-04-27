kestrel
====


Overview
--------

The Kestrel module installs and maintains the configuration of the Kestrel server.


Module Description
-------------------

The Kestrel module allows Puppet to install, configure and maintain the Kestrel server.

Setup
-----

**What kestrel affects:**

* kestrel installation directory
	
### Beginning with Kestrel

To setup Kestrel on a server

    kestrel::setup { 'example.com-kestrel':
      ensure        => 'present',
      source        => 'kestrel-2.4.1.zip',
      deploymentdir => '/home/example.com/apps/kestrel',
      user          => 'example.com'
    }

Usage
------

The `kestrel::setup` resource definition has several parameters to assist installation of kestrel .

**Parameters within `kestrel`**

####`ensure`

This parameter specifies whether kestrel should be deployed to the deployment directory or not.
Valid arguments are "present" or "absent". Default "present"

####`source`

This parameter specifies the source for the kestrel archive. 
This file must be in the files directory in the caller module. 
**Only .zip source archives are supported.**

####`deploymentdir`

This parameter specifies the directory where kestrel will be installed.

Note: If deploymentdir is set to /usr/local/, and you want to remove this installation in the future, setting ensure => 'absent' will cause the entire directory, i. e. /usr/local/ to be deleted permanently.

####`user`

This parameter is used to set the permissions for the installation directory of kestrel.


Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* CentOS 5.9
* CentOS 6.4
* Debian 6.0 
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Bug Reports
-----------

Release Notes
--------------

**0.1.0**

First initial release.
