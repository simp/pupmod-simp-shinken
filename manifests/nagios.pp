# == Class: shinken::nagios
#
#   This class is used to setup and configure nagios and various nagios plugins
# that Shinken is compatible with
#
# [*disable_old_nagios_parameters_whining*]
#
#
# [*enable_environment_macros*]
#
#
# [*enabled_embedded_perl*]
#
#
# [*enable_problem_impacts_states_change*]
#
#
# [*execute_host_checks*]
#
#
# [*execute_service_checks*]
#
#
# [*flap_history*]
#
#
# [*human_timestamp_log*]
#
#
# [*max_host_check_spread*]
#
#
# [*max_plugins_output_length*]
#
#
# [*max_service_check_spread*]
#
#
# [*no_event_handlers_during_downtimes*]
#
#
# [*retention_update_interval*]
#
#
# [*service_check_timeout*]
#
#
# [*status_update_interval*]
#
#
# [*use_large_installation_tweaks*]
#
#
# Example:
#
#   include "shinken::nagios"
#
# Will install nagios and setup all necessary configuration files with default settings
#
# == Authors
#
# Kendall Moore <kmoore@keywcorp.com>
class shinken::nagios(
  $disable_old_nagios_parameters_whining = '0',
  $enable_environment_macros             = '0',
  $enable_embedded_perl                  = '0',
  $enable_problem_impacts_states_change  = '1',
  $execute_host_checks                   = '1',
  $execute_service_checks                = '1',
  $flap_history                          = '30',
  $human_timestamp_log                   = '0',
  $max_host_check_spread                 = '5',
  $max_plugins_output_length             = '8192',
  $max_service_check_spread              = '5',
  $no_event_handlers_during_downtimes    = '1',
  $retention_update_interval             = '60',
  $service_check_timeout                 = '10',
  $status_update_interval                = '60',
  $use_large_installation_tweaks         = '1'
){

  # Just in case we only want specific ones later...
  package { 'nagios-common': ensure => 'latest' }
  package { 'nagios-plugins': ensure => 'latest' }
  package { 'nagios-plugins-all': ensure => 'latest' }
  package { 'nagios-plugins-breeze': ensure => 'latest' }
  package { 'nagios-plugins-by_ssh': ensure => 'latest' }
  package { 'nagios-plugins-cluster': ensure => 'latest' }
  package { 'nagios-plugins-dhcp': ensure => 'latest' }
  package { 'nagios-plugins-dig': ensure => 'latest' }
  package { 'nagios-plugins-disk': ensure => 'latest' }
  package { 'nagios-plugins-disk_smb': ensure => 'latest' }
  package { 'nagios-plugins-dummy': ensure => 'latest' }
  package { 'nagios-plugins-file_age': ensure => 'latest' }
  package { 'nagios-plugins-flexlm': ensure => 'latest' }
  package { 'nagios-plugins-fping': ensure => 'latest' }
  package { 'nagios-plugins-game': ensure => 'latest' }
  package { 'nagios-plugins-hpjd': ensure => 'latest' }
  package { 'nagios-plugins-http': ensure => 'latest' }
  package { 'nagios-plugins-icmp': ensure => 'latest' }
  package { 'nagios-plugins-ide_smart': ensure => 'latest' }
  package { 'nagios-plugins-ircd': ensure => 'latest' }
  package { 'nagios-plugins-ldap': ensure => 'latest' }
  package { 'nagios-plugins-load': ensure => 'latest' }
  package { 'nagios-plugins-log': ensure => 'latest' }
  package { 'nagios-plugins-mailq': ensure => 'latest' }
  package { 'nagios-plugins-mrtg': ensure => 'latest' }
  package { 'nagios-plugins-mrtgtraf': ensure => 'latest' }
  package { 'nagios-plugins-mysql': ensure => 'latest' }
  package { 'nagios-plugins-nagios': ensure => 'latest' }
  package { 'nagios-plugins-nt': ensure => 'latest' }
  package { 'nagios-plugins-ntp': ensure => 'latest' }
  package { 'nagios-plugins-ntp-perl': ensure => 'latest' }
  package { 'nagios-plugins-nwstat': ensure => 'latest' }
  package { 'nagios-plugins-oracle': ensure => 'latest' }
  package { 'nagios-plugins-overcr': ensure => 'latest' }
  package { 'nagios-plugins-perl': ensure => 'latest' }
  package { 'nagios-plugins-pgsql': ensure => 'latest' }
  package { 'nagios-plugins-ping': ensure => 'latest' }
  package { 'nagios-plugins-procs': ensure => 'latest' }
  package { 'nagios-plugins-real': ensure => 'latest' }
  package { 'nagios-plugins-rpc': ensure => 'latest' }
  package { 'nagios-plugins-sensors': ensure => 'latest' }
  package { 'nagios-plugins-smtp': ensure => 'latest' }
  package { 'nagios-plugins-snmp': ensure => 'latest' }
  package { 'nagios-plugins-ssh': ensure => 'latest' }
  package { 'nagios-plugins-swap': ensure => 'latest' }
  package { 'nagios-plugins-tcp': ensure => 'latest' }
  package { 'nagios-plugins-time': ensure => 'latest' }
  package { 'nagios-plugins-ups': ensure => 'latest' }
  package { 'nagios-plugins-users': ensure => 'latest' }
  package { 'nagios-plugins-wave': ensure => 'latest' }

  file { '/etc/shinken/nagios.cfg':
    ensure   => 'file',
    owner    => 'root',
    group    => 'root',
    mode     => '0640',
    content  => template('shinken/nagios.cfg.erb')
  }
}
