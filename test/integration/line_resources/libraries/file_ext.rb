class FileExtResource < Inspec.resource(1)
  name 'file_ext'

  desc '
    Check the number of lines in a file
  '

  example "
    describe file_ext('/tmp/output') do
      its('size_lines') { should eq 7 }
    end
  "

  def initialize(path)
    @path = path
    @file = inspec.backend.file(path)
  end

  %w(size_lines match_count).each do |m|
    define_method m.to_sym do |*args|
      file_ext.method(m.to_sym).call(*args)
    end
  end

  def to_s
    "FileExt #{@path}"
  end

  def size_lines
    if @file.exist?
      fail "FileExt #{path} is not a file" unless @file.file?
    end
    @file.exist? ? @file.content.lines.count : 0
  end
end
