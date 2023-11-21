#
# Add a line matching pattern
#

control 'replace_or_add_add_a_line_etc_hosts' do
  describe file('/etc/hosts') do
    it { should exist }
  end
  describe matches('/etc/hosts', /^# Add another line$/) do
    its('count') { should eq 1 }
  end
end
