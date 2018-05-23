property :path, String
property :line, String
property :eol, String, default: Line::OS.unix? ? "\n" : "\r\n"
property :backup, [true, false], default: false
property :ignore_missing, [true, false], default: true

resource_name :append_if_no_line

action :edit do
  raise_not_found

  new_resource.sensitive = true unless property_is_set?(:sensitive)
  eol = new_resource.eol
  string = Regexp.escape(new_resource.line)
  regex = /^#{string}$/
  current = target_current_lines

  file new_resource.path do
    content((current + [new_resource.line + eol]).join(eol))
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end

action_class do
  include Line::Helper
end
