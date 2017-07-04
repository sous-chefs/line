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
        converge_by "Updating file #{new_resource.path}" do
          f.puts new_resource.line
        end
      end
    ensure
      f.close
    end
  else
    begin
      f = ::File.open(new_resource.path, 'w')
      converge_by "Updating file #{new_resource.path}" do
        f.puts new_resource.line
      end
    ensure
      f.close
    end
  end
end

action_class.class_eval do
  include Line::Helper
end
