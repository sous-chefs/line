#
# Append a line to an empty file
#

control 'append_if_no_line_empty' do
  describe file('/tmp/emptyfile') do
    it { should exist }
    its('content') { should match /^added line$/ }
  end
  describe file_ext('/tmp/emptyfile') do
    it { should have_correct_eol }
    its('size_lines') { should eq 1 }
  end

  describe file('/tmp/missing_create') do
    it { should exist }
    its('content') { should match /^added line$/ }
  end
  describe file_ext('/tmp/missing_create') do
    it { should have_correct_eol }
    its('size_lines') { should eq 1 }
  end

  describe file('/tmp/missing_fail') do
    it { should_not exist }
  end
end
