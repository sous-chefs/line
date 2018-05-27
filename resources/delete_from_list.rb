property :path, String
property :pattern, [String, Regexp]
property :delim, Array
property :entry, String

resource_name :delete_from_list

action :edit do
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern

  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)

  begin
    f = ::File.open(new_resource.path, 'r+')

    file_owner = f.lstat.uid
    file_group = f.lstat.gid
    file_mode = f.lstat.mode

    temp_file = Tempfile.new('foo')

    modified = false

    regexdelim = []
    new_resource.delim.each do |delim|
      regexdelim << Regexp.escape(delim)
    end

    f.each_line do |line|
      # Leave the line alone if it doesn't match the regex
      temp_file.puts line unless line =~ regex
      next unless line =~ regex

      case new_resource.delim.count
      when 1
        case line
        when /#{regexdelim[0]}\s*#{new_resource.entry}/
          # remove the entry
          line = line.sub(/(#{regexdelim[0]})*\s*#{new_resource.entry}(#{regexdelim[0]})*/, new_resource.delim[0])
          # delete any trailing delimeters
          line = line.sub(/\s*(#{regexdelim[0]})*\s*$/, '')
          modified = true
        when /#{new_resource.entry}\s*#{regexdelim[0]}/
          line = line.sub(/#{new_resource.entry}(#{regexdelim[0]})*/, '')
          line = line.chomp
          modified = true
        end
      when 2
        case line
        when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
          line = line.sub(/(#{regexdelim[0]})*\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}(#{regexdelim[0]})*/, '')
          line = line.chomp
          modified = true
        end
      when 3
        case line
        when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
          line = line.sub(/(#{regexdelim[0]})*\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}(#{regexdelim[0]})*/, '')
          line = line.chomp
          modified = true
        end
      end

      temp_file.puts line

      Chef::Log.info("New line: #{line}")
    end

    f.close

    if modified
      converge_by "Updating file #{new_resource.path}" do
        temp_file.rewind
        FileUtils.copy_file(temp_file.path, new_resource.path)
        FileUtils.chown(file_owner, file_group, new_resource.path)
        FileUtils.chmod(file_mode, new_resource.path)
      end
    end
  ensure
    temp_file.close
    temp_file.unlink
  end
end

action_class.class_eval do
  require 'fileutils'
  require 'tempfile'
end
