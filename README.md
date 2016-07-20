# wpython [![Build Status](https://travis-ci.org/kckaiwei/wpython.svg?branch=master)](https://travis-ci.org/kckaiwei/wpython)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with wpython](#setup)
    * [What wpython affects](#what-wpython-affects)
    * [Setup requirements](#setup-requirements)
    * [Installation](#installation)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [init.pp](#initpp)
    * [params.pp](#paramspp)
    * [install.pp](#installpp)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

**wpython** is a puppet module that installs a version of Python onto a Window server. wpython supports version selection as well as uninstalltion.

## Setup

### What wpython affects

**wpython** uses the package resource to install and manage Python on a Windows server. Additionally, it may create a directory to hold Python installation files.

### Setup Requirements

**wpython** has no dependencies. wpython will work with Puppet straight out of the box.

### Installation

Use this command to install wpython:

`puppet module install kckaiwei-wpython`

wpython is only needed to be installed on the puppetmaster server. Installation can be done through the puppet forge, or manually.

For a manual installation, download this module as a zip, and unzip it in your modules folder. The wpython module directory should be simply named "wpython", so the node definition will recognize the module as wpython.

**Note:** If installing manually, or from this repository, ensure the folder is named "wpython" so Puppet can locate the module.

## Usage

**wpython** is used by setting variables into your node definition. wpython can be declared as a class, or simply included. Provided is an example of each use case.

```puppet
  node default {
    class { 'wpython':
      version           => '2.7.11',
      downloaddirectory => 'C:\downloads',
      uninstall         => false,
    }
  }
  
  node default {
    include wpython
  }
```

## Reference

#### init.pp

init.pp is the base class. It inherits default parameters from params.pp, and calls install.pp

```puppet
  $version          = $wpython::version
  $downloaddirectry = $wpython::downloaddirectory
  $uninstall        = $wpython::uninstall
```
Variables are declared here based on their values in the params.pp file. This provides a default value to be used if no value is set, e.g. using `include wpython` in the node definition, as opposed to adding the module as a class.

### params.pp

params.pp stores the parameters defaults. The defaults are used if no parameters are supplied to init.pp unless the node definition overrides it.

```puppet
  $version           = "2.7.12"
  $downloaddirectory = "C:/pythonfiles"
  $uninstall         = false
```
Default parameters are listed here. These are hardcoded and can be changed if you want to have a different default value when setting your own node definitions.

### install.pp

install.pp is the class that handles the installs and uninstalls

```puppet
if versioncmp('3.5', $version) <= 0{
elsif versioncmp('3.0', $version) <=0{
else {
```
We take the version number passed by the node definition to determine what resources need to be applied. Python executables change from .msi to .exe and the resource, 'package', cannot do the same actions for both of them, hence we break up the class based on version number.

versioncmp is a Puppet function that compares version numbers passed as strings. It compares the first to the second, and depending on if it is larger, equal or less, it will return a 1, 0 or -1 respectively. 

```puppet
    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/':
      ensure => directory,
      mode   => '0755',
  	  }

    file { '/etc/puppetlabs/code/environments/production/modules/ilorest/files':
      ensure  => directory,
      source  => 'puppet:///modules/ilorest',
      recurse => true,
      require => File['/etc/puppetlabs/code/environments/production/modules/ilorest'],
          }
```
File directories are created and files copied over, then managed by the master server to ensure that each node will have the required files. Note that the folder containing ilorest must already exist. Since Puppet is installed, this folder should already exist. If not, the directory path must be adjusted or the directory created.


## Limitations

**wpython** only provides support for Windows, seeing how there are already modules to install Python for 'nix distributions out there. wpython covers all released versions of Python as of this writing.

**wpython** has been tested on:
* Puppet 4.4
* Puppet Enterprise 2016.2

## Development

* Fork it!
* Create your feature branch: git checkout -b my-new-feature
* Commit your changes: git commit -am 'Add some feature'
* Push to the branch: git push origin my-new-feature
* Submit a pull request

## Release Notes/Contributors/Etc.

Version 1.0

1. Initial Release
  * Supports all Python versions as of 7/12/2016
  * Supports Windows Server 2012

Tested on:
* Windows Server 2012

Python versions tested:
* 2.7.12
* 3.4.0
* 3.5.1
* 3.5.2
