title 'add_to_list: Seperator delimiter tests'

# 'Add first entry to an empty list'
describe file('/tmp/dangerfile3') do
  its(:content) { should match(/empty_list=newentry/) }
end

# 'Add existing and new entry'
describe file('/tmp/dangerfile3') do
  its(:content) { should match(Regexp.new(Regexp.escape('People to call: Joe, Bobby, Karen, Harry'))) }
end
