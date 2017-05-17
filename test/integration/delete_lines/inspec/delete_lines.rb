title 'Delete lines'

describe file('/tmp/dangerfile1') do
  its(:content) { should_not match(/HI THERE I AM DANGERFILE/) }
end

describe file('/tmp/dangerfile2') do
  its(:content) { should_not match(/# authorized_keys/) }
end
