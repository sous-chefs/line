control 'Append lines' do
  describe file('/tmp/dangerfile') do
    its(:content) { should match(/HI THERE I AM STRING/) }
  end

  describe matches('/tmp/dangerfile', 'HI THERE I AM STRING') do
    its(:count) { should eq 1 }
  end

  describe file_ext('/tmp/dangerfile') do
    its(:size_lines) { should eq 5 }
  end
end
