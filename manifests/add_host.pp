# == Define: shinken_add_host
#
# This definition adds a host of tpye physical server, workstation, device, etc. that resides on your
# network to start being polled for data
#
# All variable definitions pulled from the Shinken host configuration documentation:
#
# [*action_url*]
#   This directive is used to define one or more optional URL that can be used to provide more
# actions to be performed on the host. If you specify an URL, you will see a red “splat” icon in
# the CGIs (when you are viewing host information) that links to the URL you specify here. Any valid
# URL can be used. If you plan on using relative paths, the base path will the the same as what is
# used to access the CGIs (i.e. /cgi-bin/shinken/)
#
# [*active_checks_enabled*]
#   This directive is used to determine whether or not active checks (either regularly scheduled
# or on-demand) of this host are enabled. Values: 0 = disable active host checks, 1 = enable
# active host checks.
#
# [*address*]
#   This directive is used to define the address of the host. Normally, this is an IP address,
# although it could really be anything you want (so long as it can be used to check the status of
# the host). You can use a FQDN to identify the host instead of an IP address, but if “DNS” services
# are not available this could cause problems. When used properly, the $HOSTADDRESS$ macro will
# contain this address.
#
# [*host_alias*]
#   The alias by which the host is referenced.
#
# [*check_command*]
#   This directive is used to specify the short name of the command that should be used to check if
# the host is up or down. Typically, this command would try and ping the host to see if it is “alive”.
# The command must return a status of OK (0) or Shinken will assume the host is down. If you leave this
# argument blank, the host will not be actively checked. Thus, Shinken will likely always assume the host
# is up (it may show up as being in a “PENDING” state in the web interface). This is useful if you are
# monitoring printers or other devices that are frequently turned off. The maximum amount of time that
# the notification command can run is controlled by the host_check_timeout option.
#
# [*check_freshness*]
#   This directive is used to determine whether or not freshness checks are enabled for this host.
# Values: 0 = disable freshness checks, 1 = enable freshness checks.
#
# [*check_interval*]
#   This directive is used to define the number of “time units” between regularly scheduled checks of the
# host. Unless you've changed the interval_length directive from the default value of 60, this number will
# mean minutes. More information on this value can be found in the check scheduling documentation.
#
# [*check_period*]
#   This directive is used to specify the short name of the time period during which active checks of this
# host can be made.
#
# [*contact_groups*]
#   This is a list of the short names of the contact groups that should be notified whenever there are
# problems (or recoveries) with this host. Multiple contact groups should be separated by commas. You
# must specify at least one contact or contact group in each host definition.
#
# [*contacts*]
#   This is a list of the short names of the contacts that should be notified whenever there are
# problems (or recoveries) with this host. Multiple contacts should be separated by commas. Useful
# if you want notifications to go to just a few people and don't want to configure contact groups.
# You must specify at least one contact or contact group in each host definition.
#
# [*display_name*]
#   This directive is used to define an alternate name that should be displayed in the web interface
# for this host. If not specified, this defaults to the value you specify for the host_name directive.
#
# [*event_handler*]
#   This directive is used to specify the short name of the command that should be run whenever a
# change in the state of the host is detected (i.e. whenever it goes down or recovers). Read the
# documentation on event handlers for a more detailed explanation of how to write scripts for handling
# events. The maximum amount of time that the event handler command can run is controlled by the
# event_handler_timeout option.
#
# [*event_handler_enabled*]
#   This directive is used to determine whether or not the event handler for this host is enabled.
# Values: 0 = disable host event handler, 1 = enable host event handler.
#
# [*failure_prediction_enabled*]
#
# [*first_notification_delay*]
#   This directive is used to define the number of “time units” to wait before sending out the first
# problem notification when this host enters a non-UP state. Unless you've changed the interval_length
# directive from the default value of 60, this number will mean minutes. If you set this value to 0, Shinken
# will start sending out notifications immediately.
#
# [*flap_detection_enabled*]
#   This directive is used to determine whether or not flap detection is enabled for this host. More
# information on flap detection can be found here. Values: 0 = disable host flap detection, 1 = enable host
# flap detection.
#
# [*flap_detection_options*]
#   This directive is used to determine what host states the flap detection logic will use for this host.
# Valid options are a combination of one or more of the following: o = UP states, d = DOWN states,
# u = UNREACHABLE states.
#
# [*freshness_threshold*]
#   This directive is used to specify the freshness threshold (in seconds) for this host. If you set this
# directive to a value of 0, Shinken will determine a freshness threshold to use automatically.
#
# [*high_flap_threshold*]
#   This directive is used to specify the high state change threshold used in flap detection for this host.
# More information on flap detection can be found here. If you set this directive to a value of 0, the
# program-wide value specified by the high_host_flap_threshold directive will be used.
#
# [*host_name*]
#   This directive is used to define a short name used to identify the host. It is used in host group and
# service definitions to reference this particular host. Hosts can have multiple services (which are monitored)
# associated with them. When used properly, the $HOSTNAME$ macro will contain this short name.
#
# [*hostgroups*]
#   This directive is used to identify the short name(s) of the hostgroup(s) that the host belongs to.
# Multiple hostgroups should be separated by commas. This directive may be used as an alternative to
# (or in addition to) using the members directive in hostgroup definitions.
#
# [*icon_image*]
#   This variable is used to define the name of a GIF, PNG, or JPG image that should be associated with
# this host. This image will be displayed in the various places in the CGIs. The image will look best if
# it is 40×40 pixels in size. Images for hosts are assumed to be in the logos/ subdirectory in your HTML
# images directory (i.e. ”/usr/local/shinken/share/images/logos”).
#
# [*icon_image_alt*]
#   This variable is used to define an optional string that is used in the ALT tag of the image specified
# by the <icon_image> argument.
#
# [*iniital_state*]
#   By default Shinken will assume that all hosts are in UP states when in starts. You can override the
# initial state for a host by using this directive. Valid options are: o = UP, d = DOWN, and u = UNREACHABLE.
#
# [*low_flap_threshold*]
#   This directive is used to specify the low state change threshold used in flap detection for this host.
# More information on flap detection can be found here. If you set this directive to a value of 0,
# the program-wide value specified by the low_host_flap_threshold directive will be used.
#
# [*max_check_attempts*]
#    This directive is used to define the number of times that Shinken will retry the host check command
# if it returns any state other than an OK state. Setting this value to 1 will cause Shinken to generate
# an alert without retrying the host check again.
#
# [*notes*]
#   This directive is used to define an optional string of notes pertaining to the host. If you specify
# a note here, you will see the it in the extended information CGI (when you are viewing information about
# the specified host).
#
# [*notes_url*]
#   This variable is used to define an optional URL that can be used to provide more information about the
# host. If you specify an URL, you will see a red folder icon in the CGIs (when you are viewing host information)
# that links to the URL you specify here. Any valid URL can be used. If you plan on using relative paths,
# the base path will the the same as what is used to access the CGIs (i.e. /cgi-bin/shinken/). This can be
# very useful if you want to make detailed information on the host, emergency contact methods, etc. available
# to other support staff.
#
# [*notification_interval*]
#   This directive is used to define the number of “time units” to wait before re-notifying a contact that
# this service is still down or unreachable. Unless you've changed the interval_length directive from the
# default value of 60, this number will mean minutes. If you set this value to 0, Shinken will not re-notify
# contacts about problems for this host - only one problem notification will be sent out.
#
# [*notification_options*]
#   This directive is used to determine when notifications for the host should be sent out. Valid options
# are a combination of one or more of the following: d = send notifications on a DOWN state,
#u = send notifications on an UNREACHABLE state, r = send notifications on recoveries (OK state),
# f = send notifications when the host starts and stops flapping, and s = send notifications when scheduled
# downtime starts and ends. If you specify n (none) as an option, no host notifications will be sent out.
# If you do not specify any notification options, Shinken will assume that you want notifications to be sent
# out for all possible states.
#
# [*notification_period*]
#   This directive is used to specify the short name of the time period during which notifications of events
# for this host can be sent out to contacts. If a host goes down, becomes unreachable, or recoveries during a
# time which is not covered by the time period, no notifications will be sent out.
#
# [*notifications_enabled*]
#   This directive is used to determine whether or not notifications for this host are enabled.
# Values: 0 = disable host notifications, 1 = enable host notifications.
#
# [*obsess_over_host*]
#   This directive determines whether or not checks for the host will be “obsessed” over using the ochp_command.
#
# [*parents*]
#   This directive is used to define a comma-delimited list of short names of the “parent” hosts for this
# particular host. Parent hosts are typically routers, switches, firewalls, etc. that lie between the
# monitoring host and a remote hosts. A router, switch, etc. which is closest to the remote host is
# considered to be that host's “parent”. Read the “Determining Status and Reachability of Network Hosts”
# document located here for more information. If this host is on the same network segment as the host doing
# the monitoring (without any intermediate routers, etc.) the host is considered to be on the local network
# and will not have a parent host. Leave this value blank if the host does not have a parent host
# (i.e. it is on the same segment as the Shinken host). The order in which you specify parent hosts has no
# effect on how things are monitored.
#
# [*passive_checks_enabled*]
#   This directive is used to determine whether or not passive checks are enabled for this host.
# Values: 0 = disable passive host checks, 1 = enable passive host checks.
#
# [*poller_tags*]
#
#
# [*process_perf_data*]
#   This directive is used to determine whether or not the processing of performance data is enabled for
# this host. Values: 0 = disable performance data processing, 1 = enable performance data processing.
#
# [*realm*]
#   This variable is used to define the realm where the host will be put. By putting the host in a realm,
# it will be manage by one of the scheduler of this realm.
#
# [*retain_nonstatus_information*]
#   This directive is used to determine whether or not non-status information about the host is retained
# across program restarts. This is only useful if you have enabled state retention using the
# retain_state_information directive. Value: 0 = disable non-status information retention,
# 1 = enable non-status information retention.
#
# [*retry_interval*]
#   This directive is used to define the number of “time units” to wait before scheduling a re-check of the
# hosts. Hosts are rescheduled at the retry interval when they have changed to a non-UP state. Once the host
# has been retried max_check_attempts times without a change in its status, it will revert to being scheduled
# at its “normal” rate as defined by the check_interval value. Unless you've changed the interval_length
# directive from the default value of 60, this number will mean minutes. More information on this value can
# be found in the check cheduling documentation.
#
# [*stalking_options*]
#   This directive determines which host states “stalking” is enabled for. Valid options are a combination
# of one or more of the following: o = stalk on UP states, d = stalk on DOWN states, and
# u = stalk on UNREACHABLE states.
#
# [*statusmap_image*]
#   This variable is used to define the name of an image that should be associated with this host in the
# statusmap CGI. You can specify a JPEG, PNG, and GIF image if you want, although I would strongly suggest
# using a GD2 format image, as other image formats will result in a lot of wasted CPU time when the statusmap
# image is generated. GD2 images can be created from PNG images by using the pngtogd2 utility supplied with
# Thomas Boutell's gd library. The GD2 images should be created in uncompressed format in order to minimize
# CPU load when the statusmap CGI is generating the network map image. The image will look best if it is
# 40×40 pixels in size. You can leave these option blank if you are not using the statusmap CGI. Images for
# hosts are assumed to be in the logos/ subdirectory in your HTML images directory
# (i.e. ”/usr/local/shinken/share/images/logos”).
#
# [*use*]
#
# [*vrml_image*]
#   This variable is used to define the name of a GIF, PNG, or JPG image that should be associated with
# this host. This image will be used as the texture map for the specified host in the statuswrl CGI.
# Unlike the image you use for the <icon_image> variable, this one should probably not have any transparency.
# If it does, the host object will look a bit wierd. Images for hosts are assumed to be in the logos/
# subdirectory in your HTML images directory (i.e. ”/usr/local/shinken/share/images/logos”).
#
# Example:
#
#    shinken::add_host { "testserver":
#        hostname => "testserver",
#        address  => "testserver.example.domain",
#        use      => "linux-server"
#    }
#
# Will create the file /etc/shinken/objects/hosts/testserver.cfg with the following content:
#
# define host {
#     host_name        testserver
#     address          testserver.example.domain
#     use              linux-server
# }
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
define shinken::add_host (
  $action_url                   = '',
  $active_checks_enabled        = '',
  $address                      = $::fqdn,
  $host_alias                   = '',
  $check_command                = '',
  $check_freshness              = '',
  $check_interval               = '',
  $check_period                 = '',
  $contact_groups               = '',
  $contacts                     = '',
  $display_name                 = '',
  $event_handler                = '',
  $event_handler_enabled        = '',
  $failure_prediction_enabled   = '',
  $first_notification_delay     = '',
  $flap_detection_enabled       = '',
  $flap_detection_options       = '',
  $freshness_threshold          = '',
  $high_flap_threshold          = '',
  $host_name                    = $::hostname,
  $hostgroups                   = '',
  $icon_image                   = '',
  $icon_image_alt               = '',
  $initial_state                = '',
  $low_flap_threshold           = '',
  $max_check_attempts           = '',
  $notes                        = '',
  $notes_url                    = '',
  $notification_interval        = '',
  $notification_options         = '',
  $notification_period          = '',
  $notifications_enabled        = '',
  $obsess_over_host             = '',
  $parents                      = '',
  $passive_checks_enabled       = '',
  $poller_tag                   = '',
  $process_perf_data            = '',
  $realm                        = '',
  $retain_nonstatus_information = '',
  $retain_status_information    = '',
  $retry_interval               = '',
  $stalking_options             = '',
  $statusmap_image              = '',
  $use                          = '',
  $vrml_image                   = ''
  )
{

  file { "/etc/shinken/objects/hosts/${name}.cfg":
    ensure  => 'file',
    owner   => 'root',
    group   => 'nagios',
    mode    => '0640',
    notify  => Service[
      ['shinken-arbiter',
      'shinken-broker',
      'shinken-poller',
      'shinken-reactionner',
      'shinken-scheduler']
    ],
    content => template('shinken/host.erb'),
  }
}
