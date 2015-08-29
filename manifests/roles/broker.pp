# == Class: shinken::roles::broker
#
#   This class installs and configures the shinken broker with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
#
# [*host*]
#   The host, usually FQDN or IP address to run the broker on
#
# [*log_level*]
#   Indicates the level at which logs are printed. Options are:
#     DEBUG
#     INFO
#     WARNING
#     ERROR
#     CRITICAL
#
# [*manage_brokers*]
#
# [*manage_sub_realms*]
#
# [*max_check_attempts*]
#   Upper bound on the number of check attempts to make before giving up
#
# [*port*]
#   The port that the shinken-broker service connects to. Default is 7772
#
# [*spare*]
#
# [*timeout*]
#   Timeout for the shinken-broker service itself to connect
#
# Example:
#
#   include "shinken::roles::broker"
#
#   Will setup shinken broker with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#
class shinken::roles::broker(
  $check_interval     = '60',
  $data_timeout       = '120',
  $host               = $::fqdn,
  $log_level          = 'WARNING',
  $manage_arbiters    = '1',
  $manage_sub_realms  = '1',
  $max_check_attempts = '3',
  $port               = '7772',
  $spare              = '0',
  $timeout            = '3'
){

  package { 'shinken-broker': ensure => 'latest' }

  file { '/etc/shinken/brokerd.ini':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/brokerd.ini.erb'),
    notify  => Service['shinken-broker']
  }

  service { 'shinken-broker':
    ensure  => 'running',
    require => Package['shinken-broker']
  }

  validate_integer($check_interval)
  validate_integer($data_timeout)
  validate_array_member($log_level, ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  validate_array_member($manage_arbiters, ['0', '1'])
  validate_array_member($manage_sub_realms, ['0', '1'])
  validate_integer($max_check_attempts)
  validate_integer($port)
  validate_array_member($spare, ['0', '1'])
  validate_integer($timeout)
}
