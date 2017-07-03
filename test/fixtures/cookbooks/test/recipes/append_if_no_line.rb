cookbook_file '/tmp/dangerfile' do
  owner 'root'
  mode '00644'
end

append_if_no_line 'Operation 1' do
  path '/tmp/dangerfile'
  line 'HI THERE I AM STRING'
end

append_if_no_line 'Operation 2' do
  path '/tmp/dangerfile'
  line 'MULE_HOME=/muleesb/mule-enterprise-standalone-3.7.2'
end

append_if_no_line 'Operation 2 redo' do
  path '/tmp/dangerfile'
  line 'MULE_HOME=/muleesb/mule-enterprise-standalone-3.7.2'
end
