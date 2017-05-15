property :name, String, name_property: true
property :path, String
property :pattern, String
property :delim, Array
property :entry, String

resource_name :delete_from_list

action :edit do
  regex = /#{new_resource.pattern}/

  begin
    raise FileNotFound unless ::File.exist?(new_resource.path)

    f = ::File.open(new_resource.path, 'r+')

    file_owner = f.lstat.uid
    file_group = f.lstat.gid
    file_mode = f.lstat.mode

    temp_file = Tempfile.new('foo')

    modified = false

    regexdelim = []
    new_resource.delim.each do |delim|
      regexdelim << escape_regex(delim)
    end

    f.each_line do |line|
      next unless line =~ regex
      case new_resource.delim.count
      when 1
        case line
        when /#{regexdelim[0]}\s*#{new_resource.entry}/
          line = line.sub(/(#{regexdelim[0]})*\s*#{new_resource.entry}(#{regexdelim[0]})*/, '')
          line = line.chomp
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
      # end
      temp_file.puts line
    end

    f.close

    if modified
      temp_file.rewind
      FileUtils.copy_file(temp_file.path, new_resource.path)
      FileUtils.chown(file_owner, file_group, new_resource.path)
      FileUtils.chmod(file_mode, new_resource.path)
      # new_resource.updated_by_last_action(true)
    end

  ensure
    temp_file.close
    temp_file.unlink
  end

end


action_class.class_eval do

  require 'fileutils'
  require 'tempfile'

  include Line::Helper
end
