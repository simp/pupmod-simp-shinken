# == Class: shinken::roles::reactionner
#
#   This class installs and configures the shinken reactionner with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
#
# [*host*]
#   The host, usually FQDN or IP address to run the reactionner on
#
# [*log_level*]
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
#   An upper bound on the number of reactionners that can run at once
#
# [*min_workers*]
#   A lower bound on the number of reactionners that can run at once
#
# [*polling_interval*]
#   The frequency at with the reactionner should run
#
# [*port*]
#   The port that the shinken-reactionner service connects to. Default is 7769
#
# [*spare*]
#
# [*timeout*]
#   Timeout for the shinken-reactionner service itself to connect
#
# Example:
#
#   include "shinken::roles::reactionner"
#
#   Will setup shinken reactionner with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#
class shinken::roles::reactionner(
  $check_interval       = '60',
  $data_timeout         = '120',
  $host                 = $::fqdn,
  $log_level            = 'WARNING',
  $manage_sub_realms    = '0',
  $max_check_attempts   = '3',
  $max_workers          = '15',
  $min_workers          = '1',
  $polling_interval     = '1',
  $port                 = '7769',
  $spare                = '0',
  $timeout              = '3'
){

  package { 'shinken-reactionner': ensure => 'latest' }

  file { '/etc/shinken/reactionnerd.ini':
    ensure   => 'file',
    owner    => 'root',
    group    => 'root',
    mode     => '0640',
    content  => template('shinken/reactionnerd.ini.erb'),
    notify   => Service['shinken-reactionner']
  }

  service { 'shinken-reactionner':
    ensure  => 'running',
    require => Package['shinken-reactionner']
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
  validate_array_member($spare, ['0', '1'])
  validate_integer($timeout)
}
