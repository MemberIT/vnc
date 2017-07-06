# == Class: vnc
#
# Full description of class vnc here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'vnc':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class vnc (
   $vncusername    =  undef,
   $ensure         =  'present',
   $userpassword   =  '!!',
   $vncpassword    =  '!!',
   $vncport        =  undef,
   $browser1       =  'google-chrome',  #For ubuntu 
   $browser2       =  'google-chrome',  #For centos
) {
  validate_string($vncusername)
  validate_re($ensure, '^present$|^absent$')

  class { 'vnc::install': } -> class { 'vnc::config': } -> class { 'vnc::service': }

$vncusers = hiera('vnc', {})
create_resources('vnc', $vncusers)
}
