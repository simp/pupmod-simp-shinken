# == Class: shinken::roles::arbiter
#
#   This class installs and configures the shinken arbiter with reasonable
# default values
#
# [*check_interval*]
#   The time to wait between checks
#
# [*data_timeout*]
#   The timeout to wait for collecting data
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
#   The port that the shinken-arbiter service connects to. Default is 7770
#
# [*spare*]
#
# [*timeout*]
#   Timeout for the shinken-arbiter service itself to connect
#
# Example:
#
#   include "shinken::roles::arbiter"
#
#   Will setup shinken arbiter  with reasonable defaults and ensure that the service is running
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
#
class shinken::roles::arbiter(
  $check_interval     = '60',
  $data_timeout       = '120',
  $max_check_attempts = '3',
  $log_level          = 'WARNING',
  $port               = '7770',
  $spare              = '0',
  $timeout            = '3'
){

  package { 'shinken-arbiter': ensure => 'latest' }

  service { 'shinken-arbiter':
    ensure  => 'running',
    require => Package['shinken-arbiter']
  }

  validate_integer($check_interval)
  validate_integer($data_timeout)
  validate_array_member($log_level, ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'])
  validate_integer($max_check_attempts)
  validate_integer($port)
  validate_array_member($spare, ['0', '1'])
  validate_integer($timeout)
}
