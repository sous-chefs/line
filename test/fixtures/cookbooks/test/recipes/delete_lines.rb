cookbook_file '/tmp/dangerfile1' do
  owner 'root'
  mode '00644'
end

cookbook_file '/tmp/dangerfile2' do
  owner 'root'
  mode '00644'
end

delete_lines 'Operation 5' do
  path '/tmp/dangerfile1'
  pattern '^HI.*'
end

delete_lines 'Operation 6' do
  path '/tmp/dangerfile1'
  pattern '^#.*'
end

delete_lines 'Operation 7' do
  path '/tmp/dangerfile1'
  pattern '^#.*'
end

delete_lines 'Operation 8' do
  path '/tmp/dangerfile2'
  pattern '^#.*'
end
