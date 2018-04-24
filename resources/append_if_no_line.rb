include OS

property :path, String
property :line, String
property :eol, String, default: OS.unix? ? "\n" : "\r\n"

resource_name :append_if_no_line

action :edit do
  eol = new_resource.eol
  $/ = eol
  string = Regexp.escape(new_resource.line)
  regex = /^#{string}$/
  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)
  current = ::File.binread(new_resource.path).split(/#{eol}/)

  # we match the regexp after doing this append for files without terminating CRs.  should
  # we instead match against the unchanged content?  we're basically saying "don't worry
  # about terminating CRs or not, we gotcha covered" which feels like the 99% use case.  but
  # is there a 1% use case here which considers this a bug?
  # 
  # split removes the eol characters, join puts them back or adds them if missing.
  # Adding a line implies there is a seperator on the previous line.  Adding
  # a line differs from appending characters.
  #
  # current[-1] = current[-1].chomp(eol) + eol if current[-1].respond_to?(:chomp)

  file new_resource.path do
    content((current + [new_resource.line + eol]).join(eol))
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end
