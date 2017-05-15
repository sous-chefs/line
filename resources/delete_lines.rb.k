property :name, String, name_property: true
property :path, String
property :pattern, String

resource_name :delete_lines

action :edit do
  regex = /#{new_resource.pattern}/

  if ::File.exist?(new_resource.path)
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
  end # ::File.exists
end # def action_edit


action_class.class_eval do
  require 'fileutils'
  require 'tempfile'
end
