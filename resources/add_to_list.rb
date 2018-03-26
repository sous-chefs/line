property :path, String
property :pattern, String
property :delim, Array
property :entry, String
property :ends_with, String

resource_name :add_to_list

action :edit do
  ends_with = new_resource.ends_with ? Regexp.escape(new_resource.ends_with) : ''
  regex = /#{new_resource.pattern}.*#{ends_with}/

  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)

  begin
    f = ::File.open(new_resource.path, 'r+')

    file_owner = f.lstat.uid
    file_group = f.lstat.gid
    file_mode = f.lstat.mode

    temp_file = ::Tempfile.new('foo')

    modified = false

    regexdelim = []
    new_resource.delim.each do |delim|
      regexdelim << Regexp.escape(delim)
    end

    f.each_line do |line|
      # Leave the line alone if it doesn't match the regex
      temp_file.puts line unless line =~ regex
      next unless line =~ regex

      if new_resource.ends_with
        list_end = line.rindex(new_resource.ends_with)
        seperator = line =~ /#{new_resource.pattern}.*\S.*#{ends_with}/ ? new_resource.delim[0] : ''
        case new_resource.delim.count
        when 1
          next if line =~ /(#{regexdelim[0]}|#{new_resource.pattern})\s*#{new_resource.entry}\s*(#regexdelim[0]|#{ends_with})/
          line = line.chomp.insert(list_end, "#{seperator}#{new_resource.entry}")
          modified = true
        when 2
          next if line =~ /#{regexdelim[1]}#{new_resource.entry}\s*#{regexdelim[1]}/
          line = line.chomp.insert(list_end, "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[1]}")
          modified = true
        when 3
          next if line =~ /#{regexdelim[1]}#{new_resource.entry}\s*#{regexdelim[2]}/
          line = line.chomp.insert(list_end, "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[2]}")
          modified = true
        end
      else
        seperator = line =~ /#{new_resource.pattern}.*\S.*$/ ? new_resource.delim[0] : ''
        case new_resource.delim.count
        when 1
          next if line =~ /((#{regexdelim[0]})*|#{new_resource.pattern})\s*#{new_resource.entry}(#{regexdelim[0]}|\n)/
          line = line.chomp + "#{seperator}#{new_resource.entry}"
          modified = true
        when 2
          next if line =~ /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
          line = line.chomp + "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[1]}"
          modified = true
        when 3
          next if line =~ /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
          line = line.chomp + "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[2]}"
          modified = true
        end
      end
      temp_file.puts line

      Chef::Log.info("New line: #{line}")
    end

    f.close unless f.nil?

    if modified
      converge_by "Updating file #{new_resource.path}" do
        temp_file.rewind
        FileUtils.copy_file(temp_file.path, new_resource.path)
        FileUtils.chown(file_owner, file_group, new_resource.path)
        FileUtils.chmod(file_mode, new_resource.path)
      end
    end
  ensure
    temp_file.close unless f.nil?
    temp_file.unlink unless f.nil?
  end
end

action_class.class_eval do
  require 'fileutils'
  require 'tempfile'
end
