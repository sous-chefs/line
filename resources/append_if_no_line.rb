property :path, String
property :line, String

resource_name :append_if_no_line

action :edit do
  string = Regexp.escape(new_resource.line)
  regex = /^#{string}$/

  temp_file = Tempfile.new('line-cookbook')

  found = false
  if ::File.exist?(new_resource.path)
    source = ::File.open(new_resource.path, 'r+')
    source.each_line do |line|
      found = true if line =~ regex
      temp_file.puts line
    end
  end

  unless found
    temp_file.puts new_resource.line
    temp_file.close

    hacky_file new_resource.path do
      injected_tempfile temp_file
    end
  end
end
