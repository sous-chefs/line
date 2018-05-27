control 'Replace or add to a missing file' do
  describe matches('/tmp/missingfile', /^add this line$/) do
    its('count') { should eq 1 }
  end

  describe file_ext('/tmp/missingfile') do
    its('size_lines') { should eq 1 }
  end

  describe matches('/tmp/missingfile_matches_pattern', /^add this line$/) do
    its('count') { should eq 1 }
  end

  describe file_ext('/tmp/missingfile_matches_pattern') do
    its('size_lines') { should eq 1 }
  end

  describe file('/tmp/missingfile_replace_only') do
    it { should_not exist }
  end

  # redo of resource did nothing
  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/missing_file redo.*n$/) }
    its(:content) { should match(/missing_file matches_pattern redo.*n$/) }
    its(:content) { should match(/missing_file replace_only.*n$/) }
  end
end
