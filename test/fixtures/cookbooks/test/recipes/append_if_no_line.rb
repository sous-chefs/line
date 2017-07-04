cookbook_file '/tmp/dangerfile' do
  owner 'root'
  mode '00644'
  :create_if_missing
end

append_if_no_line 'Operation' do
  path '/tmp/dangerfile'
  line 'HI THERE I AM STRING'
end

append_if_no_line 'Operation redo' do
  path '/tmp/dangerfile'
  line 'HI THERE I AM STRING'
end
