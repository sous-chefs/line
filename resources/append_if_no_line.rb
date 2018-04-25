property :path, String
property :line, String
property :eol, String, default: Line::OS.unix? ? "\n" : "\r\n"
property :sensitive, [true, false], default: true
property :backup, [true, false], default: false

resource_name :append_if_no_line

action :edit do
  eol = new_resource.eol
  $/ = eol
  string = Regexp.escape(new_resource.line)
  regex = /^#{string}$/
  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)
  current = ::File.binread(new_resource.path).split(eol)

  file new_resource.path do
    content((current + [new_resource.line + eol]).join(eol))
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end
