#
# Replace or add with missing file
#

control 'replace_or_add_missing_file' do
  describe file('/tmp/missingfile') do
    it { should_not exist }
  end
  describe file('/tmp/missingfile_replace_only') do
    it { should_not exist }
  end

  describe file('/tmp/missingfile_no_match') do
    it { should exist }
  end
  describe matches('/tmp/missingfile_no_match', /^add this line$/) do
    its('count') { should eq 1 }
  end
  describe file_ext('/tmp/missingfile_no_match') do
    it { should have_correct_eol }
    its('size_lines') { should eq 1 }
  end

  describe file('/tmp/missingfile_matches_pattern') do
    it { should exist }
  end
  describe matches('/tmp/missingfile_matches_pattern', /^add this line$/) do
    its('count') { should eq 1 }
  end
  describe file_ext('/tmp/missingfile_matches_pattern') do
    it { should have_correct_eol }
    its('size_lines') { should eq 1 }
  end
end
