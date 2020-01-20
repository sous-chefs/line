control 'Check removed duplicate lines' do
  eol = os.family == 'windows' ? "\r\n" : "\n"

  describe matches('/tmp/no_duplicate', /^Remove duplicate lines#{eol}/) do
    its('count') { should eq 1 }
  end
  describe matches('/tmp/no_duplicate', /^Identical line#{eol}/) do
    its('count') { should eq 0 }
  end

  describe matches('/tmp/no_duplicate_replace_only', /^Remove duplicate lines#{eol}/) do
    its('count') { should eq 1 }
  end
  describe matches('/tmp/no_duplicate_replace_only', /^Identical line#{eol}/) do
    its('count') { should eq 0 }
  end

  # redo of resource did nothing
  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/duplicate redo.*n#{eol}/) }
  end
end
