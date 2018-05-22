property :path, String
property :pattern, [String, Regexp]
property :eol, String, default: Line::OS.unix? ? "\n" : "\r\n"
property :backup, [true, false], default: false
property :ignore_missing, [true, false], default: true

resource_name :delete_lines

action :edit do
  file_exist = ::File.exist?(new_resource.path)
  return if !file_exist && new_resource.ignore_missing
  raise "File #{new_resource.path} not found" unless file_exist

  new_resource.sensitive = true unless property_is_set?(:sensitive)
  eol = new_resource.eol
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern
  current = ::File.binread(new_resource.path).split(eol)
  new = current.reject { |l| l =~ regex }
  new[-1] += eol unless new[-1].to_s.empty?

  file new_resource.path do
    content new.join(eol)
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { new == current }
  end
end
