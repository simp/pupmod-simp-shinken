# == Class: shinken
#
# This class takes the latest shinken install and adds security to the web
# interface using Apache.
#
# For complete details on the capabilities and limitations of Shinken, please
# visit their website: http://www.shinken-monitoring.org/
#
# [*client_nets*]
#   An array of networks to which to allow access to the shinken web interface.
#   This only takes effect if you're not managing httpd.
#
# [*host*]
#   The fqdn of the host shinken is being installed on
#
# [*hostname*]
#   The short hostname of the host shinken is bieng installed on
#
# [*ldapuri*]
#   The LDAP URI to connect to OpenLDAP
#
# [*ldap_basedn*]
#   The base DN for connection to OpenLDAP
#
# [*ldap_bind_dn*]
#   The LDAP Bind DN
#
# [*ldap_bind_pw*]
#   The LDAP Bind User's password
#
# [*manage_httpd*]
#   Boolean to determine whether or not Shinken should be used to manage
#   Apache. This should be left as true if no other applications will be using
#   and configuring an Apache instance. If set to false, all SSL and web
#   security will not be managed by Shinken and will be left to the user
#
# [*mysql_root_password*]
#   The root password of the MySQL server, to be used when creating Shinken
#   MySQL databses
#
# [*shinken_db_password*]
#   The password for the Shinken specific database
#
# [*use_mysql*]
#   Boolean to tell Shinken whether or not to use a MySQL backend
#
# [*web_ip*]
#   The IP address for connecting to the Web UI
#
# [*web_ui_auth_secret*]
#   The auth secret to be set for the Web UI
#
# == Author
#
# * Kendall Moore <kmoore@keywcorp.com>
#
class shinken(
  $client_nets         = hiera('client_nets'),
  $host                = $::fqdn,
  $hostname            = $::hostname,
  $ldapuri             = hiera('ldap::uri'),
  $ldap_basedn         = hiera('ldap::base_dn'),
  $ldap_bind_dn        = hiera('ldap::bind_dn'),
  $ldap_bind_pw        = hiera('ldap::bind_pw'),
  $manage_httpd        = true,
  $mysql_root_password = '',
  $shinken_db_password = '',
  $use_mysql           = false,
  $web_ip              = $::ipaddress_lo,
  $web_ui_auth_secret
){

  package { 'shinken': ensure => 'latest' }
  package { 'php': ensure => 'latest' }
  package { 'python-ldap': ensure => 'latest' }

  pam::access::manage { 'nagios':
    users   => 'nagios',
    origins => ['ALL']
  }

  if $manage_httpd {
    include 'apache::ssl'
    include 'shinken::httpd::shinken_apache'
  }
  else {
    iptables::add_tcp_stateful_listen { 'allow_shinken_web_ui':
      client_nets => $client_nets,
      dports      => '7767'
    }
  }

  if $use_mysql {
    class { 'shinken::db::mysql':
      mysql_root_password => $mysql_root_password,
      db_password         => $shinken_db_password,
    }
  }

  include 'shinken::roles::arbiter'
  include 'shinken::roles::broker'
  include 'shinken::roles::poller'
  include 'shinken::roles::reactionner'
  include 'shinken::roles::receiver'
  include 'shinken::roles::scheduler'

  file { '/etc/shinken/commands.cfg':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0640'
  }

  concat_build { 'contactgroups':
    order  => ['*.group'],
    target => '/etc/shinken/contactgroups.cfg',
    notify => Service['shinken-arbiter']
  }

  file { '/etc/shinken/resource.cfg':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/resource.cfg.erb'),
    notify  => Service['shinken-arbiter']
  }

  file { '/etc/shinken/servicegroups.cfg':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/servicegroups.cfg.erb'),
    notify  => Service['shinken-arbiter']
  }

  file { '/etc/shinken/shinken-specific.cfg':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('shinken/shinken-specific.cfg.erb'),
    notify  => Service['shinken-arbiter', 'shinken-broker']
  }

  include 'shinken::nagios'

  validate_bool($manage_httpd)
  validate_bool($use_mysql)
}
