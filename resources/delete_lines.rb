property :path, String
property :pattern, [String, Regexp]

resource_name :delete_lines

action :edit do
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern

  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)

  current = ::File.readlines(new_resource.path)

  new = current.reject { |l| l =~ regex }

  file new_resource.path do
    content new.join
    not_if { new == current }
  end
end
