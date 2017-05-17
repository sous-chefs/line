cookbook_file '/tmp/dangerfile' do
  owner 'root'
  mode '00644'
end

append_if_no_line 'Operation 1' do
  path '/tmp/dangerfile'
  line 'HI THERE I AM STRING'
end
