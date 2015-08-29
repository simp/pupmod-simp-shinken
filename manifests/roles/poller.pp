# == Class: shinken::roles::poller
#
#   This class installs and configures the shinken poller with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
#
# [*host*]
#   The host, usually FQDN or IP address to run the poller on
#
# [*log_level]
#   Indicates the level at which logs are printed. Options are:
#     DEBUG
#     INFO
#     WARNING
#     ERROR
#     CRITICAL
#
# [*manage_sub_realms*]
#
# [*max_check_attempts*]
#   Upper bound on the number of check attempts to make before giving up
#
# [*max_workers*]
#   An upper bound on the number of pollers allowed to run at once
#
# [*min_workers*]
#   A lower bound on the number of pollers allowed to run at once
#
# [*polling_interval*]
#   The frequency at which the poller(s) should execute
#
# [*port*]
#   The port that the shinken-poller service connects to. Default is 7771
#
# [*processes_by_worker*]
#   The numbers of processes to be executed by a given poller
#
# [*timeout*]
#   Timeout for the shinken-poller service itself to connect
#
# Example:
#
#   include "shinken::roles::poller"
#
#   Will setup shinken poller with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#

class shinken::roles::poller(
  $check_interval       = '60',
  $data_timeout         = '120',
  $host                 = $::fqdn,
  $hostname             = $::hostname,
  $log_level            = 'WARNING',
  $manage_sub_realms    = '0',
  $max_check_attempts   = '3',
  $max_workers          = '4',
  $min_workers          = '4',
  $polling_interval     = '1',
  $port                 = '7771',
  $processes_by_worker  = '256',
  $timeout              = '3'
){

  package { 'shinken-poller': ensure => 'latest' }

  file { '/etc/shinken/pollerd.ini':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/pollerd.ini.erb'),
    notify  => Service['shinken-poller']
  }

  service { 'shinken-poller':
    ensure  => 'running',
    require => Package['shinken-poller']
  }

  validate_integer($check_interval)
  validate_integer($data_timeout)
  validate_array_member($log_level, ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  validate_array_member($manage_sub_realms, ['0', '1'])
  validate_integer($max_check_attempts)
  validate_integer($max_workers)
  validate_integer($min_workers)
  validate_integer($polling_interval)
  validate_integer($port)
  validate_integer($processes_by_worker)
  validate_integer($timeout)
}
