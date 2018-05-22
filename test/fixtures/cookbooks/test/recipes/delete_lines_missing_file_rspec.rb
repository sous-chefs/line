file 'prep for test /tmp/nofilehere' do
  path '/tmp/nofilehere'
  action :delete
end

delete_lines 'missing_file fail' do
  path '/tmp/nofilehere'
  pattern '^#.*'
  ignore_missing false
end
