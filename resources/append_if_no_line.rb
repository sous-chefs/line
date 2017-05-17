property :name, String, name_property: true
property :path, String
property :line, String

resource_name :append_if_no_line

action :edit do
  string = escape_string new_resource.line
  regex = /^#{string}$/

  if ::File.exist?(new_resource.path)
    begin
      f = ::File.open(new_resource.path, 'r+')

      found = false
      f.each_line { |line| found = true if line =~ regex }

      unless found
        f.puts new_resource.line
        new_resource.updated_by_last_action(true)
      end
    ensure
      f.close
    end
  else
    begin
      f = ::File.open(new_resource.path, 'w')
      f.puts new_resource.line
    ensure
      f.close
    end
  end
end

action_class.class_eval do
  include Line::Helper
end
