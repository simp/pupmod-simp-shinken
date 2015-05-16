Puppet::Type.type(:shinken_add_command).provide(:add_command) do

  def exists?
    retval = false
    lines.each do |line|
      if line.chomp =~ /^\s*command_name\s+#{resource[:command_name]}\s*$/
        retval = true
      end
    end
    retval
  end

  def create
    File.open("/etc/shinken/commands.cfg", "a") do |fh|
      newlines =  "define command {\n"
      newlines << "       command_name        #{resource[:command_name]}\n"
      newlines << "       command_line        #{resource[:command_line]}\n"
      newlines << "}\n"
      fh.puts(newlines)
    end
  end

  def destroy
    Puppet.warning("destroy is not defined for custom type shinken_add_command")
  end

  private

  def lines
    begin
      return File.readlines("/etc/shinken/commands.cfg")
    rescue Exception
      Puppet.warning("File /etc/shinken/commands.cfg does not exist.")
    end
  end
end
