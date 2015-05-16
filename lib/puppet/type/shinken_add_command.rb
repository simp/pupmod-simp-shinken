Puppet::Type.newtype(:shinken_add_command) do

  desc <<-EOT
    Add a Shinken command to the /etc/shinken/command.cfg file. This can be useful for writing
    custom commands for Shinken or Nagios.

    Example:

        add_command { 'foo':
            command_name => 'foo',
            command_line => 'bar'
        }

    In this example the the command called "foo" is run by executing the "bar" on the
    command line.
  EOT

  ensurable do
    defaultvalues
    defaultto :present
  end

  newparam(:name, :namevar => true) do
    desc 'An arbitrary name used as the identity of the resource'
  end

  newparam(:command_name) do
    desc 'The name of the command as it will appear in the Shinken dashboard'
  end

  newparam(:command_line) do
    desc 'The name of the executable as it will be run on the command line'
  end

  validate do
    unless self[:command_name] and self[:command_line]
      raise(Puppet::Error, "Both command_name and command_line are required attributes")
    end
  end
end
