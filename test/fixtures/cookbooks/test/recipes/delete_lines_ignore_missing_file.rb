delete_lines 'missing_file' do
  path '/tmp/nofilehere'
  pattern '^#.*'
  ignore_missing true
end
