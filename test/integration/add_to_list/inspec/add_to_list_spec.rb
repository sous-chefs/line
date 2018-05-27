title 'Add to list'

describe file('/tmp/dangerfile3') do
  its(:content) { should match(/empty_list=newentry/) }
end

# It should not re-add an existing item
describe file('/tmp/dangerfile3') do
  its(:content) { should match(%r{DEFAULT_APPEND="resume=/dev/sda2 splash=silent crashkernel=256M-:128M showopts addtogrub"}) }
end

# Add to an empty list
describe file('/tmp/dangerfile3') do
  its(:content) { should match(/empty_delimited_list=\(\"newentry\"\)/) }
end
