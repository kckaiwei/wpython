# Class: hprest
# ===========================
#
# ilorest is a module that installs the Python ilorest library, and launches a few examples
# from the library using parameters passed to the node.
#
# Parameters
# ----------
# * `ilo_ip`
# This parameter is the IP address of the target server. It defaults to "10.0.0.100"
# It is required for the examples to execute properly.
#
# * `ilo_username`
# This parameter is the iLO username for the target server. It defaults to "username"
# It is required for the examples to execute properly.
#
# * `ilo_password`
# This parameter is the iLO password for the target server. It defaults to "password"
# It is required for the examples to execute properly.
#
# Examples
# --------
#
# @example
# class { "hprest":
#   ilo_ip         => '10.0.0.100',
#   ilo_username   => 'admin',
#   ilo_password   => 'password',
#   hprest_command => '&& hprest types',
# }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#

class wpython (

  $version = $wpython::params::version,


) inherits wpython::params {

  include wpython::install
  
}
