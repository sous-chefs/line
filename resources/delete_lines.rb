property :path, String
property :pattern, String

resource_name :delete_lines

action :edit do
  regex = /#{new_resource.pattern}/

  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)

  begin
    f = ::File.open(new_resource.path, 'r+')

    file_owner = f.lstat.uid
    file_group = f.lstat.gid
    file_mode = f.lstat.mode

    temp_file = Tempfile.new('foo')

    modified = false

    f.each_line do |line|
      if line =~ regex
        modified = true
      else
        temp_file.puts line
      end
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
