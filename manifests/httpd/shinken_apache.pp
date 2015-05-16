# == Class: shinken::httpd::shinken_apache
#
# Sets up an Apache web front-end for Shinken. This is done to allow trusted SSL
# connections to the Shinken web interface.
#
# == Parameters
#
# [*method_acl*]
# [*redirect_web_root*]
# [*shinken_proxy*]
# [*shinken_uri*]
# [*ssl_verify_client*]
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
# * Trevor Vaughan <tvaughan@onyxpoint.com>
#
class shinken::httpd::shinken_apache(
  $method_acl = {},
  $redirect_web_root = false,
  $shinken_proxy = 'http://127.0.0.1:7767',
  $shinken_uri = 'shinken',
  $ssl_verify_client = 'none',
) {

  include 'apache::conf'
  include 'apache::ssl'
  include '::shinken::defaults'
  include '::apache::validate'

  validate_hash($method_acl)

  $l_method_acl = deep_merge($::shinken::defaults::method_acl, $method_acl)
  validate_deep_hash($::apache::validate::method_acl, $l_method_acl)

  $httpd_includes = '/etc/httpd/conf.d/shinken'

  apache::add_site { 'shinken':
    content => template('shinken/etc/httpd/conf.d/shinken.conf.erb')
  }

  file { $httpd_includes:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'apache',
    mode    => '0640',
    require => Package['httpd']
  }

  # This is just so that we can wildcard.
  file { [
    "$httpd_includes/auth",
    "$httpd_includes/limit",
    "$httpd_includes/limit_int",
  ]:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'apache',
    mode    => '0640'
  }

  $l_apache_auth = apache_auth($l_method_acl['method'])

  if $l_apache_auth != '' {
    file { "$httpd_includes/auth/auth.conf":
      ensure  => 'file',
      owner   => 'root',
      group   => 'apache',
      mode    => '0640',
      content => "$l_apache_auth\n",
      notify  => Service['httpd']
    }
  }

  $limit_conf_content = $l_apache_limits ? {
    # Set some sane defaults.
    ''      => "<Limit GET POST PUT>
        Order deny,allow
        Deny from all
        Allow from 127.0.0.1
        Allow from $::fqdn
      </Limit>",
    default => "$l_apache_limits\n"
  }

  # This is for the main limits (not the shinken-int space)
  $l_apache_limits = apache_limits($l_method_acl['limits'])
  file { "$httpd_includes/limit/limits.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'apache',
    mode    => '0640',
    content => $limit_conf_content,
    notify  => Service['httpd']
  }

  # This is for shinken-int
  $l_apache_limits_int = apache_limits(deep_merge(
    $l_method_acl['limits'],
    {
      'defaults' => array_union($l_method_acl['limits']['defaults'],['DELETE'])
    }))

  $limit_int_conf = $l_apache_limits ? {
    # Set some sane defaults.
    ''      => "<Limit GET POST PUT DELETE>
        Order deny,allow
        Deny from all
        Allow from 127.0.0.1
        Allow from $::fqdn
      </Limit>",
    default => "$l_apache_limits\n"
  }

  file { "$httpd_includes/limit_int/limits.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'apache',
    mode    => '0640',
    content => $limit_int_conf,
    notify  => Service['httpd']
  }
}
