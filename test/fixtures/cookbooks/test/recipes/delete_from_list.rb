cookbook_file '/tmp/dangerfile3' do
  owner 'root'
  mode '00644'
end

# Delete the first entry in a list with delimited entries
delete_from_list 'Delete Operation 1' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '10.0.0.0/8'
end

# # Delete the last entry in a list with delimited entries
delete_from_list 'Delete Operation 2' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '192.168.0.0/16'
end

delete_from_list 'Delete Operation 3' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Joe'
end

delete_from_list 'Delete Operation 4' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Karen'
end

delete_from_list 'Delete Operation 5' do
  path '/tmp/dangerfile3'
  pattern 'multi = '
  delim [', ', '[', ']']
  entry '425'
end
#
