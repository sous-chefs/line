property :path, String
property :pattern, [String, Regexp]
property :line, String
property :replace_only, [true, false]

resource_name :replace_or_add

action :edit do
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern

  if ::File.exist?(new_resource.path)
    begin
      f = ::File.open(new_resource.path, 'r+')

      file_owner = f.lstat.uid
      file_group = f.lstat.gid
      file_mode = f.lstat.mode

      temp_file = Tempfile.new('foo')

      modified = false
      found = false

      f.each_line do |line|
        if line =~ regex || line.chomp == new_resource.line
          found = true
          unless line.chomp == new_resource.line
            line = new_resource.line
            modified = true
          end
        end

        temp_file.puts line
      end

      unless found || new_resource.replace_only # "add"!
        temp_file.puts new_resource.line
        modified = true
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
  else
    unless new_resource.replace_only
      converge_by "Updating file #{new_resource.path}" do
        begin
          nf = ::File.open(new_resource.path, 'w')
          nf.puts new_resource.line
        rescue ENOENT
          Chef::Log.info('ERROR: Containing directory does not exist for #{nf.class}')
        ensure
          nf.close
        end
      end
    end
  end
end

action_class.class_eval do
  require 'fileutils'
  require 'tempfile'
end
