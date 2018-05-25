property :backup, [true, false], default: false
property :eol, String, default: Line::OS.unix? ? "\n" : "\r\n"
property :ignore_missing, [true, false], default: true
property :line, String
property :path, String
property :pattern, [String, Regexp]
property :replace_only, [true, false]

resource_name :replace_or_add

action :edit do
  raise_not_found
  sensitive_default
  eol = new_resource.eol
  found = false
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern
  new = []
  current = target_current_lines

  # replace
  current.each do |line|
    line = line.dup
    if line =~ regex || line == new_resource.line
      found = true
      line = new_resource.line unless line == new_resource.line
    end
    new << line
  end

  # add
  new << new_resource.line unless found || new_resource.replace_only

  # Last line terminator
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
