# == Class: shinken::roles::scheduler
#
#   This class installs and configures the shinken scheduler with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
#
# [*host*]
#   The host, usually FQDN or IP address to run the scheduler on
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
#   The port that the shinken-scheduler service connects to. Default is 7768
#
# [*spare*]
#
# [*timeout*]
#   Timeout for the shinken-scheduler service itself to connect
#
# [*weight*]
#
# Example:
#
#   include "shinken::roles::scheduler"
#
#   Will setup shinken scheduler with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#

class shinken::roles::scheduler(
  $check_interval     = '60',
  $data_timeout       = '120',
  $host               = $::fqdn,
  $log_level          = 'WARNING',
  $max_check_attempts = '3',
  $port               = '7768',
  $spare              = '0',
  $timeout            = '3',
  $weight             = '1'
){

  package { 'shinken-scheduler': ensure => 'latest' }

  file { '/etc/shinken/schedulerd.ini':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/schedulerd.ini.erb'),
    notify  => Service['shinken-scheduler']
  }

  service { 'shinken-scheduler':
    ensure  => 'running',
    require => Package['shinken-scheduler']
  }

  validate_integer($check_interval)
  validate_integer($data_timeout)
  validate_array_member($log_level, ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  validate_integer($max_check_attempts)
  validate_integer($port)
  validate_array_member($spare, ['0', '1'])
  validate_integer($timeout)
  validate_integer($weight)
}
