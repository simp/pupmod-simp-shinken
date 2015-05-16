# == Define: shinken::add_command
#
# This definition adds a command to the Shinken commands.cfg file
#
# [*command_name*]
#   The name of the command as it will appear in the Shinken web UI
#
# [*command_line*]
#   The executable as it will be run from the command line
#
# Example:
#
#    shinken::add_command { "test_command":
#        command_line => "/bin/ls -l"
#    }
#
# Will append the following to /etc/shinken/commands.cfg:
#
# define command {
#        command_name        test_command
#        command_line        /bin/ls -l
# }
#
# == Authors
#
# * Kendall Moore <kmoore@keywcorp.com>
#
define shinken::add_command (
  $command_line,
  $command_name = $name
) {

  shinken_add_command { $name:
    command_name => $command_name,
    command_line => $command_line,
    require      => File['/etc/shinken/commands.cfg']
  }
}
