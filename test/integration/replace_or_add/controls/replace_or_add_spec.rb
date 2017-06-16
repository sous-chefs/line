title 'Replace or add lines'

describe file('/tmp/dangerfile') do
  its(:content) { should match(/hey there how you doin/) }
end

describe file('/tmp/dangerfile2') do
  its(:content) { should_not match(/ssh-rsa AAAAB3NzaC1yc2EAAAADDEADBEEFDERPDERPDERPILIKESSHTOO skelator@grayskull/) }
  its(:content) { should match(/ssh-rsa change 2/) }
end
