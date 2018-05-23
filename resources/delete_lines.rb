property :path, String
property :pattern, [String, Regexp]
property :eol, String, default: Line::OS.unix? ? "\n" : "\r\n"
property :backup, [true, false], default: false
property :ignore_missing, [true, false], default: true

resource_name :delete_lines

action :edit do
  return if !target_file_exist? && new_resource.ignore_missing
  raise_not_found

  new_resource.sensitive = true unless property_is_set?(:sensitive)
  eol = new_resource.eol
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern
  current = target_current_lines
  new = current.reject { |l| l =~ regex }
  new[-1] += eol unless new[-1].to_s.empty?

  file new_resource.path do
    content new.join(eol)
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { new == current }
  end
end

action_class do
  include Line::Helper
end
