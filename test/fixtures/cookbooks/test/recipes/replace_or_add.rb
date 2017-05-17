cookbook_file '/tmp/dangerfile' do
  owner 'root'
  mode '00644'
end

cookbook_file '/tmp/dangerfile2' do
  owner 'root'
  mode '00644'
end

replace_or_add 'Operation 2' do
  path '/tmp/dangerfile'
  pattern 'hey there.*'
  line 'hey there how you doin'
end

replace_or_add 'Operation 3' do
  path '/tmp/dangerfile'
  pattern 'hey there.*'
  line 'hey there how you doin'
end

replace_or_add 'Operation 4' do
  path '/tmp/dangerfile2'
  pattern 'ssh-rsa AAAAB3NzaC1yc2EAAAADDEADBEEF.*'
  line ''
end
