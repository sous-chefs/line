control 'Replace or add lines' do
  describe file('/tmp/dangerfile') do
    its(:content) { should match(/hey there how you doin/) }
  end

  describe file('/tmp/dangerfile2') do
    its(:content) { should_not match(/ssh-dsa/) }
    its(:content) { should match(/ssh-rsa change 2/) }
  end
end
