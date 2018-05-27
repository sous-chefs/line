property :path, String
property :line, String

resource_name :append_if_no_line

action :edit do
  string = Regexp.escape(new_resource.line)
  regex = /^#{string}$/

  raise "File #{new_resource.path} not found" unless ::File.exist?(new_resource.path)

  current = ::File.readlines(new_resource.path)
  # we match the regexp after doing this append for files without terminating CRs.  should
  # we instead match against the unchanged content?  we're basically saying "don't worry
  # about terminating CRs or not, we gotcha covered" which feels like the 99% use case.  but
  # is there a 1% use case here which considers this a bug?
  current[-1] = current[-1].chomp + "\n" if current[-1].respond_to?(:chomp)

  file new_resource.path do
    content((current + [new_resource.line + "\n"]).join)
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end
