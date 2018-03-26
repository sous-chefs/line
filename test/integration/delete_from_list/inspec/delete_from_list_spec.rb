title 'Delete from list'

describe file('/tmp/dangerfile3') do
  its(:content) { should_not match(/192\.168\.0\.0/) }
  its(:content) { should_not match(/10\.0\.0\.0/) }
  its(:content) { should match(/172\.16\.0\.0/) }
end

describe file('/tmp/dangerfile3') do
  its(:content) { should_not match(/425/) }
end

describe file('/tmp/dangerfile3') do
  its(:content) { should_not match(/Joe/) }
  its(:content) { should_not match(/Karen/) }
  its(:content) { should match(/People to call: Bobby/) }
end

control 'File should still contain' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should match(/last_delimited_list= \(\|single\|\)/) }
  end
end

describe file('/tmp/dangerfile3') do
  its(:content) { should match(/reported$/) }
  its(:content) { should match(/altform$/) }
  its(:content) { should match(/double  space  entry  fin$/) }
  its(:content) { should match(/^list, comma-space, fourth$/) }
  its(:content) { should match(/^list ,space-comma ,fourth$/) }
end
