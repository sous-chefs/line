title 'Append lines'

describe file('/tmp/dangerfile') do
  its(:content) { should match(/HI THERE I AM STRING/) }
end
