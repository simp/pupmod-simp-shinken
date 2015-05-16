# == Define: shinken::add_contactgroup
#
# This definiton will add a contact group to the Shinken contactgroups.cfg file.
#
# [*alias*]
#   The alias or longers description of the contact group
#
# [*contactgroup_name*]
#   The short name used to define the contact group
#
# [*members*]
#   A list of members which will be added to the contact group
#
# Example:
#
#    shinken::add_contactgroup { "admins":
#        members => ["user1", "user2", "user3", "user4"]
#    }
#
# Will append the following to /etc/shinken/contactgroups.cfg:
#
# define contactgroup {
#        contactgroup_name        admins
#        alias                    admins
#        members                  user1,user2,user3,user4
# }
#
# And the users user1, user2, user3, and user4 will be added to the contactgroup
# called admins
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
define shinken::add_contactgroup (
  $members           ,
  $alias             = $name,
  $contactgroup_name = $name
) {

  concat_fragment { "contactgroups+$name.group":
    content => template('shinken/contactgroups.cfg.erb')
  }
}
