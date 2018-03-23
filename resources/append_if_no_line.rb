property :path, String
property :line, String

resource_name :append_if_no_line

action :edit do
  string = escape_string new_resource.line
  regex = /^#{string}$/

  current = ::File.readlines(new_resource.path)
  current[-1] = current[-1].chomp + "\n"

  file new_resource.path do
    content ( current + [ new_resource.line + "\n" ] ).join
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end

action_class.class_eval do
  include Line::Helper
end
