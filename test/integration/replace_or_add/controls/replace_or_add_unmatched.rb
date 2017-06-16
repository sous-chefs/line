
title 'Add a line that does not match the pattern'

describe matches('/tmp/unmatched', /^Unmatched line$/) do
  its('count') { should eq 1 }
end

describe matches('/tmp/unmatched', /^Unmatched line$/) do
  its('count') { should eq 1 }
end

# redo of resource did nothing
describe file('/tmp/chef_resource_status') do
  its(:content) { should match(/unmatched redo.*n$/) }
end
