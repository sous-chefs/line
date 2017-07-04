control 'Append lines' do
  describe file('/tmp/dangerfile') do
    its(:content) { should match(/HI THERE I AM STRING/) }
  end

  describe matches('/tmp/dangerfile', 'muleesb') do
    its(:count) { should eq 1 }
  end

  describe file_ext('/tmp/dangerfile') do
    its(:size_lines) { should eq 6 }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/append_if_no_line.*Operation 2 redo.*n$/) }
  end
end
