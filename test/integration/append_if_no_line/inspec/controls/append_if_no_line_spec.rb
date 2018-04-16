control 'Append lines' do
  describe file('/tmp/dangerfile') do
    its(:content) { should match(/HI THERE I AM STRING/) }
  end

  describe matches('/tmp/dangerfile', 'HI THERE I AM STRING') do
    its(:count) { should eq 1 }
  end

  describe matches('/tmp/dangerfile', 'AM I A STRING?+\'".*/-\(){}^$[]') do
    its(:count) { should eq 1 }
  end

  describe file_ext('/tmp/dangerfile') do
    its(:size_lines) { should eq 6 }
  end

  describe file('/tmp/file_without_linereturn') do
    its(:content) { should eql("no carriage return line\nSHOULD GO ON ITS OWN LINE\n") }
  end

  describe file('/tmp/file_without_linereturn2') do
    its(:content) { should eql('no carriage return line') }
  end

  describe file('/tmp/emptyfile') do
    its(:content) { should eql("added line\n") }
  end
end
