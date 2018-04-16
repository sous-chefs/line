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

append_if_no_line 'with special chars' do
  path '/tmp/dangerfile'
  line 'AM I A STRING?+\'".*/-\(){}^$[]'
end

append_if_no_line 'with special chars redo' do
  path '/tmp/dangerfile'
  line 'AM I A STRING?+\'".*/-\(){}^$[]'
end

file '/tmp/file_without_linereturn' do
  content 'no carriage return line'
end

append_if_no_line 'should go on its own line' do
  path '/tmp/file_without_linereturn'
  line 'SHOULD GO ON ITS OWN LINE'
end

file '/tmp/file_without_linereturn2' do
  content 'no carriage return line'
end

append_if_no_line 'should not edit the file' do
  path '/tmp/file_without_linereturn'
  line 'no carriage return line'
end

file '/tmp/emptyfile'

append_if_no_line 'should add to empty file' do
  path '/tmp/emptyfile'
  line 'added line'
end
