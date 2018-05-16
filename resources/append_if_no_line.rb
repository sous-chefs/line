property :path, String
property :line, String
property :ignore_leading_whitespace, [true, false], default: false
property :ignore_trailing_whitespace, [true, false], default: false

resource_name :append_if_no_line

action :edit do
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

action_class do
  def regex
    string = Regexp.escape(new_resource.line)
    if new_resource.ignore_leading_whitespace && new_resource.ignore_trailing_whitespace
      /^\s*#{string}\s*$/
    elsif new_resource.ignore_leading_whitespace
      /^\s*#{string}$/
    elsif new_resource.ignore_trailing_whitespace
      /^#{string}\s*$/
    else
      /^#{string}$/
    end
  end
end
