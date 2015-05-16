# == Define: shinken::add_contact
#
# This definition adds a contact to Shinken by generating a user specific config
# file at /etc/shinken/objects/contacts/<contact_name>.cfg
#
# Documentation for specific variables comes from the Shinken contact
# descriptions in the Shinken documentation.
#
#
# [*alias*]
#   This directive is used to define a longer name or description for
#   the contact. Under the rights circumstances, the $CONTACTALIAS$
#   macro will contain this value. If not specified, the contact_name
#   will be used as the alias.
#
# [*can_submit_commands*]
#    This directive is used to determine whether or not the contact
#    can submit external commands to Shinken from the CGIs. Values:
#
#      0 = don't allow contact to submit commands
#      1 = allow contact to submit commands.
#
# [*contact_name*]
#   The name of the contact to be added to Shinken
#
# [*contactgroups*]
#   This directive is used to identify the short name(s) of the
#   contactgroup(s) that the contact belongs to. Multiple
#   contactgroups should be separated by commas. This directive may be
#   used as an alternative to (or in addition to) using the members
#   directive in contactgroup definitions.
#
# [*email*]
#   The email address of the contact being added
#
# [*host_notification_commands*]
#   This directive is used to define a list of the short names of the
#   commands used to notify the contact of a host problem or recovery.
#   Multiple notification commands should be separated by commas. All
#   notification commands are executed when the contact needs to be
#   notified. The maximum amount of time that a notification command
#   can run is controlled by the notification_timeout option.
#
# [*host_notification_options*]
#    This directive is used to define the host states for which
#    notifications can be sent out to this contact. Valid options are
#    a combination of one or more of the following:
#
#      d = notify on DOWN host states
#      u = notify on UNREACHABLE host states
#      r = notify on host recoveries (UP states)
#      f = notify when the host starts and stops flapping,
#      s = send notifications when host or service scheduled downtime
#          starts and ends. If you specify n (none) as an option, the contact
#          will not receive any type of host notifications.
#
# [*host_notification_period*]
#   This directive is used to specify the short name of the time
#   period during which the contact can be notified about host
#   problems or recoveries. You can think of this as an "on call" time
#   for host notifications for the contact. Read the documentation on time
#   periods for more information on how this works and potential problems
#   that may result from improper use.
#
# [*host_notifications_enabled*]
#    This directive is used to determine whether or not the contact
#    will receive notifications about host problems and recoveries.
#    Values :
#
#      0 = don't send notifications
#      1 = send notifications
#
# [*is_admin*]
#    This directive is used to determine whether or not the contact
#    can see all object in WebUI. Values:
#
#      0 = normal user, can see all objects he is in contact
#      1 = allow contact to see all objects
#
# [*min_business_impact*]
#    This directive is use to define the minimum business criticity
#    level of a service/host the contact will be notified. Please see
#    root_problems_and_impacts for more details.
#
#      0 = less important
#      1 = more important than 0
#      2 = more important than 1
#      3 = more important than 2
#      4 = more important than 3
#      5 = most important
#
# [*password*]
#   The optional password to be assocaited with the contact being added
#
# [*retain_nonstatus_information*]
#    This directive is used to determine whether or not non-status
#    information about the contact is retained across program
#    restarts. This is only useful if you have enabled state retention
#    using the retain_state_information directive. Value :
#
#      0 = disable non-status information retention
#      1 = enable non-status information retention
#
# [*retain_status_information*]
#    This directive is used to determine whether or not status-related
#    information about the contact is retained across program
#    restarts. This is only useful if you have enabled state retention
#    using the retain_state_information directive. Value :
#
#      0 = disable status information retention
#      1 = enable status information retention.
#
# [*service_notification_commands*]
#   This directive is used to define a list of the short names of the
#   commands used to notify the contact of a service problem or
#   recovery. Multiple notification commands should be separated by
#   commas. All notification commands are executed when the contact
#   needs to be notified. The maximum amount of time that a
#   notification command can run is controlled by the
#   notification_timeout option.
#
# [*service_notification_options*]
#    This directive is used to define the service states for which
#    notifications can be sent out to this contact. Valid options are
#    a combination of one or more of the following:
#
#    w = notify on WARNING service states
#    u = notify on UNKNOWN service states
#    c = notify on CRITICAL service states
#    r = notify on service recoveries (OK states)
#    f = notify when the service starts and stops flapping.
#    n = (none) : the contact will not receive any type of service
#        notifications.
#
# [*service_notification_period*]
#   This directive is used to specify the short name of the time
#   period during which the contact can be notified about service
#   problems or recoveries. You can think of this as aervice
#   notifications for the contact. Read the documentation on time
#   periods for more information on how this works and potential
#   problems that may result from improper use.
#
# [*service_notifications_enabled*]
#   This directive is used to determine whether or not the contact will
#   receive notifications about service problems and recoveries. Values:
#
#      0 = don't send notifications
#      1 = send notifications
#
# [*use*]
#   The type of contact which is being added
#
# Example:
#
#    shinken::add_contact { "user1":
#        email => "user1@example.com",
#        use   => "generic-contact"
#    }
#
# Will create /etc/shinken/objects/contacts/user1.cfg with the following content:
#
# define contact {
#        use                 generic_contact
#        contact_name        user1
#        email               user1@example.com
# }
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
define shinken::add_contact (
  $email                         ,
  $use                           ,
  $can_submit_commands           = '0',
  $contact_alias                 = undef,
  $contact_name                  = $name,
  $contactgroups                 = undef,
  $host_notification_commands    = undef,
  $host_notification_options     = undef,
  $host_notification_period      = undef,
  $host_notifications_enabled    = undef,
  $is_admin                      = '0',
  $min_business_impact           = undef,
  $password                      = undef,
  $retain_nonstatus_information  = undef,
  $retain_status_information     = undef,
  $service_notification_commands = undef,
  $service_notification_options  = undef,
  $service_notification_period   = undef,
  $service_notifications_enabled = undef
) {

  file { "/etc/shinken/objects/contacts/${contact_name}.cfg":
    ensure  => 'file',
    owner   => 'root',
    group   => 'nagios',
    mode    => '0640',
    notify  => Service['shinken-arbiter'],
    content => template('shinken/contact.erb'),
  }
}
