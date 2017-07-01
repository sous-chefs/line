control 'Change the last line of a file' do
  describe file('/tmp/change_line_eof') do
    its('content') { should match(/^Last line changed$/) }
  end

  describe file_ext('/tmp/change_line_eof') do
    its('size_lines') { should eq 7 }
  end

  describe matches('/tmp/change_line_eof', /^Last line changed$/) do
    its('count') { should eq 1 }
  end

  # redo of resource did nothing
  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/change_line_eof redo.*n$/) }
  end
end
