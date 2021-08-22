#
# Append to empty file
#

file '/tmp/emptyfile'

append_if_no_line 'should add to empty file' do
  path '/tmp/emptyfile'
  line 'added line'
end

append_if_no_line 'missing_file' do
  path '/tmp/missing_create'
  line 'added line'
end

append_if_no_line 'missing_file fail' do
  path '/tmp/missing_fail'
  line 'added line'
  ignore_missing false
  ignore_failure true
end
