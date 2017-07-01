control 'Change multiple lines with one pass' do
  describe matches('/tmp/replace_only', /^Replace duplicate lines$/) do
    its('count') { should eq 2 }
  end

  describe matches('/tmp/replace_only_nomatch', /^Replace duplicate lines$/) do
    its('count') { should eq 0 }
  end

  # redo of resource did nothing
  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/replace_only redo.*n$/) }
    its(:content) { should match(/replace_only_nomatch.*n$/) }
  end
end
