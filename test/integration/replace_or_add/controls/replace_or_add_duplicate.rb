control 'Change multiple lines with one pass' do
  describe matches('/tmp/duplicate', /^Replace duplicate lines$/) do
    its('count') { should eq 2 }
  end

  describe matches('/tmp/duplicate_replace_only', /^Replace duplicate lines$/) do
    its('count') { should eq 2 }
  end

  # redo of resource did nothing
  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/duplicate redo.*n$/) }
  end
end
