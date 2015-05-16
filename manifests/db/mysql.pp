# == Class: shinken::db_mysql
#
# Sets up a MySQL server as needed and a MySQL database to store Shinken
# data and Shinken user-specific information.
#
# == Parameters
#
# [*mysql_root_password*]
#   The password for the MySQL root user.
#
# [*db_password*]
#   The passowrd for the Shinken database.
#
# [*client_nets*]
#   Default: $::shinken::web_ip
#   The client networks that should be able to access the MySQL DB for Shinken.
#
# [*bind_address*]
#   The bind address to user for establishing the MySQL connection.
#
# [*charset*]
#   The charset to use for MySQL. Defaults to UTF-8.
#
# [*dbname*]
#   The name of the Shinken database. Defaults to shinken.
#
# [*user*]
#   The user to connect to the Shinken database. Defaults to nagios.
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
class shinken::db::mysql (
  $mysql_root_password  ,
  $db_password          ,
  $client_nets          = [$::shinken::web_ip],
  $bind_address         = '0.0.0.0',
  $charset              = 'utf8',
  $dbname               = 'shinken',
  $user                 = 'nagios'
) {

  iptables::add_tcp_stateful_listen { 'allow_mysql':
    client_nets => $client_nets,
    dports      => '3306'
  }

  include 'mysql::python'

  class { 'mysql::server':
    config_hash => {
      'root_password' => $mysql_root_password,
      'bind_address'  => $bind_address
    }
  }

  mysql::db { $dbname:
    user     => $user,
    password => $mysql_root_password,
    host     => $bind_address,
    charset  => $charset,
    require  => Class['mysql::config']
  }
}
