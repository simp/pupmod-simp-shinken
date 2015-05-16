# == Class: shinken::roles::receiver
#
#   This class installs and configures the shinken receiver with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
#
# [*host*]
#   The host, usually FQDN or IP address to run the receiver on
#
# [*log_level*]
#   Indicates the level at which logs are printed. Options are:
#     DEBUG
#     INFO
#     WARNING
#     ERROR
#     CRITICAL
#
# [*max_check_attempts*]
#   Upper bound on the number of check attempts to make before giving up
#
# [*port*]
#   The port that the shinken-receiver service connects to. Default is 7773
#
# [*spare*]
#
# [*timeout*]
#   Timeout for the shinken-receiver service itself to connect
#
# Example:
#
#   include "shinken::roles::receiver"
#
#   Will setup shinken receiver with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#

class shinken::roles::receiver(
  $check_interval     = '60',
  $data_timeout       = '120',
  $host               = $::fqdn,
  $log_level          = 'WARNING',
  $max_check_attempts = '3',
  $port               = '7773',
  $spare              = '0',
  $timeout            = '3'
){

  package { 'shinken-receiver': ensure => 'latest' }

  file { '/etc/shinken/receiverd.ini':
    ensure   => 'file',
    owner    => 'root',
    group    => 'root',
    mode     => '0640',
    content  => template('shinken/receiverd.ini.erb'),
    notify   => Service['shinken-receiver']
  }

  service { 'shinken-receiver':
    ensure  => 'running',
    require => Package['shinken-receiver']
  }

  validate_integer($check_interval)
  validate_integer($data_timeout)
  validate_array_member($log_level, ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  validate_integer($max_check_attempts)
  validate_integer($port)
  validate_array_member($spare, ['0', '1'])
  validate_integer($timeout)
}
