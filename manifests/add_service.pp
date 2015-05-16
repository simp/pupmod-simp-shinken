# == Define: shinken::add_service
#
# This definition adds a service which is to be run on a host. A service can be any check that is used
# for collecting data to be shown in the Shinken Web UI
#
# All variable definitions pulled from the Shinken service configuration documentation
#
# [*action_url*]
#   This directive is used to define an optional URL that can be used to provide more actions to be
# performed on the service. If you specify an URL, you will see a red “splat” icon in the CGIs (when you
# are viewing service information) that links to the URL you specify here. Any valid URL can be used. If
# you plan on using relative paths, the base path will the the same as what is used to access the CGIs
# (i.e. /cgi-bin/shinken/).
#
# [*active_checks_enabled*]
#    This directive is used to determine whether or not active checks of this service are enabled. Values:
#  0 = disable active service checks
#  1 = enable active service checks.
#
# [*business_impact*]
#   This variable is used to set the importance we gave to this service from the less important
# (0 = nearly nobody will see if it's in error) to the maximum (5 = you lost your job if it fail).
# The default value is 2.
#
# [*check_command*]
#    This directive is used to specify the short name of the command that Shinken will run in order to
# check the status of the service. The maximum amount of time that the service check command can run is
# controlled by the service_check_timeout option. There is also a command with the reserved name “bp_rule”.
# It is defined internally and has a special meaning. Unlike other commands it mustn't be registered in a
# command definition. It's purpose is not to execute a plugin but to represent a logical operation on the
# statuses of other services. It is possible to define logical relationships with the following operators :
#
#    & : it's use to make an AND betweens statuses
#    | : it's use to make an OR betweens statuses
#    ! : it's use to make a NOT of a status or expression
#    , : it's use to make a OR, like the | sign.
#    ( and ) : they are used like in all math expressions.
#
# For example the following definition of a business process rule is valid :
#
#    bp_rule!(websrv1,apache | websrv2,apache) & dbsrv1,oracle
#
# If at least one of the apaches on servers websrv1 and websrv2 is OK and if the oracle database on dbsrv1
# is OK then the rule and thus the service is OK
#
# [*check_freshness*]
#    This directive is used to determine whether or not freshness checks are enabled for this service. Values:
#
#    0 = disable freshness checks
#    1 = enable freshness checks
#
# [*check_interval*]
#   This directive is used to define the number of “time units” to wait before scheduling the next “regular”
# check of the service. “Regular” checks are those that occur when the service is in an OK state or when the
# service is in a non-OK state, but has already been rechecked max_check_attempts number of times. Unless
# you've changed the interval_length directive from the default value of 60, this number will mean minutes.
# More information on this value can be found in the check scheduling documentation.
#
# [*check_period*]
#   This directive is used to specify the short name of the time period during which active checks of this
# service can be made.
#
# [*contacts*]
#   This is a list of the short names of the contacts that should be notified whenever there are problems
# (or recoveries) with this service. Multiple contacts should be separated by commas. Useful if you want
# notifications to go to just a few people and don't want to configure contact groups. You must specify at
# least one contact or contact group in each service definition.
#
# [*contact_groups*]
#   This is a list of the short names of the contact groups that should be notified whenever there are
# problems (or recoveries) with this service. Multiple contact groups should be separated by commas. You
# must specify at least one contact or contact group in each service definition.
#
# [*display_name*]
#   This directive is used to define an alternate name that should be displayed in the web interface for
# this service. If not specified, this defaults to the value you specify for the service_description directive.
#
# [*event_handler*]
#   This directive is used to specify the short name of the command that should be run whenever a change in
# the state of the service is detected (i.e. whenever it goes down or recovers). Read the documentation on
# event handlers for a more detailed explanation of how to write scripts for handling events. The maximum
# amount of time that the event handler command can run is controlled by the event_handler_timeout option.
#
# [*event_handler_enabled*]
#    This directive is used to determine whether or not the event handler for this service is enabled. Values:
#
#    0 = disable service event handler
#    1 = enable service event handler.
#
# [*first_notification_delay*]
#   This directive is used to define the number of “time units” to wait before sending out the first problem
# notification when this service enters a non-OK state. Unless you've changed the interval_length directive
# from the default value of 60, this number will mean minutes. If you set this value to 0, Shinken will start
# sending out notifications immediately.
#
# [*flap_detection_enabled*]
#    This directive is used to determine whether or not flap detection is enabled for this service. More
# information on flap detection can be found here. Values:
#
#    0 = disable service flap detection
#    1 = enable service flap detection.
#
# [*flap_detection_options*]
#    This directive is used to determine what service states the flap detection logic will use for this
# service. Valid options are a combination of one or more of the following :
#
#    o = OK states
#    w = WARNING states
#    c = CRITICAL states
#    u = UNKNOWN states.
#
# [*freshness_threshold*]
#    This directive is used to specify the freshness threshold (in seconds) for this service. If you set
# this directive to a value of 0, Shinken will determine a freshness threshold to use automatically.
#
# [*high_flap_threshold*]
#   This directive is used to specify the high state change threshold used in flap detection for this service.
# More information on flap detection can be found here. If you set this directive to a value of 0, the
# program-wide value specified by the high_service_flap_threshold directive will be used.
#
# [*host_name*]
#    This directive is used to specify the short name(s) of the host(s) that the service “runs” on or is
# associated with. Multiple hosts should be separated by commas.
#
# [*hostgroup_name*]
#   This directive is used to specify the short name(s) of the hostgroup(s) that the service “runs” on or
# is associated with. Multiple hostgroups should be separated by commas. The hostgroup_name may be used
# instead of, or in addition to, the host_name directive.
#
# [*icon_image*]
#   This variable is used to define the name of a GIF, PNG, or JPG image that should be associated with
# this service. This image will be displayed in the status and extended information CGIs. The image will
# look best if it is 40×40 pixels in size. Images for services are assumed to be in the logos/ subdirectory
# in your HTML images directory (i.e. ”/usr/local/shinken/share/images/logos”).
#
# [*icon_image_alt*]
#   This variable is used to define an optional string that is used in the ALT tag of the image specified
# by the <icon_image> argument. The ALT tag is used in the status, extended information and statusmap CGIs.
#
# [*icon_set*]
#   This variable is used to set the icon in the Shinken Webui. For now, values are only : database, disk,
# network_service, server
#
# [*initial_state*]
#    By default Shinken will assume that all services are in OK states when in starts. You can override
# the initial state for a service by using this directive. Valid options are:
#
#    o = OK
#    w = WARNING
#    u = UNKNOWN
#    c = CRITICAL.
#
# [*is_volatile*]
#   This directive is used to denote whether the service is “volatile”. Services are normally not
# volatile. More information on volatile service and how they differ from normal services can be found here.
#    Value: 0 = service is not volatile, 1 = service is volatile.
#
# [*low_flap_threshold*]
#   This directive is used to specify the low state change threshold used in flap detection for this
# service. More information on flap detection can be found here. If you set this directive to a value of 0,
# the program-wide value specified by the low_service_flap_threshold directive will be used.
#
# [*maintenance_period*]
#   Shinken-specific variable to specify a recurring downtime period. This works like a scheduled downtime,
# so unlike a check_period with exclusions, checks will still be made (no ”blackout” times).
#
# [*max_check_attempts*]
#   This directive is used to define the number of times that Shinken will retry the service check command
# if it returns any state other than an OK state. Setting this value to 1 will cause Shinken to generate an
# alert without retrying the service check again.
#
# [*notes*]
#   This directive is used to define an optional string of notes pertaining to the service. If you specify
# a note here, you will see the it in the extended information CGI (when you are viewing information about
# the specified service.)
#
# [*notes_url*]
#   This directive is used to define an optional URL that can be used to provide more information about
# the service. If you specify an URL, you will see a red folder icon in the CGIs (when you are viewing
# service information) that links to the URL you specify here. Any valid URL can be used. If you plan on
# using relative paths, the base path will the the same as what is used to access the CGIs
# (i.e. /cgi-bin/shinken/). This can be very useful if you want to make detailed information on the service,
# emergency contact methods, etc. available to other support staff.
#
# [*notifications_enabled*]
#    This directive is used to determine whether or not notifications for this service are enabled. Values:
#
#    0 = disable service notifications
#    1 = enable service notifications.
#
# [*notification_interval*]
#   This directive is used to define the number of “time units” to wait before re-notifying a contact that
# this service is still in a non-OK state. Unless you've changed the interval_length directive from the default
# value of 60, this number will mean minutes. If you set this value to 0, Shinken will not re-notify contacts
# about problems for this service - only one problem notification will be sent out.
#
# [*notification_options*]
#    This directive is used to determine when notifications for the service should be sent out.
# Valid options are a combination of one or more of the following:
#
#    w = send notifications on a WARNING state
#    u = send notifications on an UNKNOWN state
#    c = send notifications on a CRITICAL state
#    r = send notifications on recoveries (OK state)
#    f = send notifications when the service starts and stops flapping
#    s = send notifications when scheduled downtime starts and ends
#    n (none) as an option, no service notifications will be sent out. If you do not specify any
#    notification options, Shinken will assume that you want notifications to be sent out for all possible states
#
# If you specify w,r in this field, notifications will only be sent out when the service goes into a WARNING
# state and when it recovers from a WARNING state.
#
# [*notification_period*]
#   This directive is used to specify the short name of the time period during which notifications of events
# for this service can be sent out to contacts. No service notifications will be sent out during times which
# is not covered by the time period.
#
# [*obsess_over_service*]
#   This directive determines whether or not checks for the service will be “obsessed” over using the ocsp_command.
#
# [*passive_checks_enabled*]
#    This directive is used to determine whether or not passive checks of this service are enabled. Values:
#
#    0 = disable passive service checks
#    1 = enable passive service checks.
#
# [*poller_tag*]
#    This variable is used to define the poller_tag of checks from this service. All of theses checks will be
# taken by pollers that have this value in their poller_tags parameter. By default there is no poller_tag,
# so all untaggued pollers can take it.
#
# [*process_perf_data*]
#    This directive is used to determine whether or not the processing of performance data is enabled for
# this service. Values:
#
#    0 = disable performance data processing
#    1 = enable performance data processing
#
# [*retain_status_information*]
#    This directive is used to determine whether or not status-related information about the service is
# retained across program restarts. This is only useful if you have enabled state retention using the
# retain_state_information directive. Value:
#
#    0 = disable status information retention
#    1 = enable status information retention.
#
# [*retain_nonstatus_information*]
#    This directive is used to determine whether or not non-status information about the service is retained
# across program restarts. This is only useful if you have enabled state retention using the
# retain_state_information directive. Value:
#
#    0 = disable non-status information retention
#    1 = enable non-status information retention
#
# [*retry_interval*]
#   This directive is used to define the number of “time units” to wait before scheduling a re-check of
# the service. Services are rescheduled at the retry interval when they have changed to a non-OK state.
# Once the service has been retried max_check_attempts times without a change in its status, it will revert
# to being scheduled at its “normal” rate as defined by the check_interval value. Unless you've changed the
# interval_length directive from the default value of 60, this number will mean minutes. More information on
# this value can be found in the check scheduling documentation.
#
# [*servicegroups*]
#    This directive is used to identify the short name(s) of the servicegroup(s) that the service belongs to.
# Multiple servicegroups should be separated by commas. This directive may be used as an alternative to using
# the members directive in servicegroup definitions.
#
# [*service_dependencies*]
#   This variable is used to define services that this service is dependent of for notifications.
# It's a comma separated list of services: host,service_description,host,service_description. For each
# service a service_dependency will be created with default values (notification_failure_criteria as 'u,c,w'
# and no dependency_period). For more complex failure criteria or dpendency period you must create a
# service_dependency object, as described in advanced dependency configuraton. The host can be omitted from
# the configuration, which means that the service dependency is for the same host.
#
# [*service_description*]
#   This directive is used to define the description of the service, which may contain spaces, dashes,
# and colons (semicolons, apostrophes, and quotation marks should be avoided). No two services associated
# with the same host can have the same description. Services are uniquely identified with their host_name
# and service_description directives.
#
# [*stalking_options*]
#    This directive determines which service states “stalking” is enabled for. Valid options are a combination
# of one or more of the following :
#
#    o = stalk on OK states
#    w = stalk on WARNING states
#    u = stalk on UNKNOWN states
#    c = stalk on CRITICAL states
#
# [*use*]
#
# Example:
#
#    shinken::add_service { "check_ssh_on_testserver":
#        check_command => "check_ssh",
#        host_name     => "testserver"
#    }
#
# Will create the file /etc/shinken/objects/services/check_ssh.cfg with the following content:
#
# define service {
#    use                  generic-service
#    host_name            testserver
#    service_description  check_ssh_on_testserver
#    check_command        check_ssh
# }
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
define shinken::add_service (
    $check_command                ,
    $action_url                   = '',
    $active_checks_enabled        = '',
    $business_impact              = '',
    $check_freshness              = '',
    $check_interval               = '',
    $check_period                 = '',
    $contacts                     = '',
    $contact_groups               = '',
    $display_name                 = '',
    $event_handler                = '',
    $event_handler_enabled        = '',
    $first_notification_delay     = '',
    $flap_detection_enabled       = '',
    $flap_detection_options       = '',
    $freshness_threshold          = '',
    $high_flap_threshold          = '',
    $host_name                    = $::hostname,
    $hostgroup_name               = '',
    $icon_image                   = '',
    $icon_image_alt               = '',
    $icon_set                     = '',
    $initial_state                = '',
    $is_volatile                  = '',
    $low_flap_threshold           = '',
    $maintenance_period           = '',
    $max_check_attempts           = '',
    $notes                        = '',
    $notes_url                    = '',
    $notifications_enabled        = '',
    $notification_interval        = '',
    $notification_options         = '',
    $notification_period          = '',
    $obsess_over_service          = '',
    $passive_checks_enabled       = '',
    $poller_tag                   = '',
    $process_perf_data            = '',
    $retain_status_information    = '',
    $retain_nonstatus_information = '',
    $retry_interval               = '',
    $servicegroups                = '',
    $service_dependencies         = '',
    $service_description          = $name,
    $stalking_options             = '',
    $use                          = 'generic-service'
)
{

  file { "/etc/shinken/objects/services/${name}.cfg":
    ensure  => 'file',
    owner   => 'root',
    group   => 'nagios',
    mode    => '0640',
    notify  => Service['shinken-arbiter'],
    content => template('shinken/service.erb'),
  }
}
