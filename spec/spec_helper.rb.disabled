require 'chefspec'

RSpec.configure do |config|
  config.color = true               # Use color in STDOUT
  config.formatter = :documentation # Use the specified formatter
  config.log_level = :error         # Avoid deprecation notice SPAM
end

def file_replacement
  allow(::File).to receive(:exist?).and_call_original
  allow(Tempfile).to receive(:new).and_call_original
  allow(FileUtils).to receive(:copy_file).and_call_original
  # Specific replacements
  allow(::File).to receive(:exist?).with('file').and_return(true)
  fake_file = StringIO.open(@file_content)
  fake_lstat = double
  allow(::File).to receive(:open).with('file', 'r+').and_return(fake_file)
  allow(fake_file).to receive(:lstat).and_return(fake_lstat)
  allow(fake_lstat).to receive(:uid).and_return(0)
  allow(fake_lstat).to receive(:gid).and_return(0)
  allow(fake_lstat).to receive(:mode).and_return(775)
  allow(fake_file).to receive(:close) { fake_file.rewind }
  allow(Tempfile).to receive(:new).with('foo').and_return(@temp_file)
  allow(@temp_file).to receive(:close) { @temp_file.rewind }
  allow(@temp_file).to receive(:unlink)
  allow(FileUtils).to receive(:copy_file).with(@temp_file.path, 'file') { @file_content = @temp_file.read }
  allow(FileUtils).to receive(:chown)
  allow(FileUtils).to receive(:chmod)
  missing_file = double
  allow(::File).to receive(:exist?).with('missingfile').and_return(false)
  allow(::File).to receive(:open).with('missingfile', 'w').and_return(missing_file)
  allow(missing_file).to receive(:puts) { |line| @file_content << "#{line}\n" }
  allow(missing_file).to receive(:close)
end
