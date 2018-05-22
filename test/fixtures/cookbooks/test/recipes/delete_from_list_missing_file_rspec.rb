file 'prep for test /tmp/nofilehere' do
  path '/tmp/nofilehere'
  action :delete
end

delete_from_list 'missing_file fail' do
  path '/tmp/nofilehere'
  pattern 'multi = '
  delim [', ', '[', ']']
  entry '425'
  ignore_missing false
end
