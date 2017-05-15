title 'Delete from list'

control 'Entry should not exist' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should_not match(/192\.168\.0\.0/) }
    its(:content) { should_not match(/10\.0\.0\.0/) }
  end
end

control 'the first complex delimited entry' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should_not match(/310/) }
  end
end


control 'the last complex delimited entry' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should_not match(/425/) }
  end
end

control 'the first simply delimited entry' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should_not match(/Joe/) }
  end
end

control 'File should still contain' do
  describe file('/tmp/dangerfile3') do
    its(:content) { should match(/last_delimited_list= \(\|single\|\)/) }
  end
end
