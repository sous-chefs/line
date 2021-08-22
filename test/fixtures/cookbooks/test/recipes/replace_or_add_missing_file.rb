#
# Test replace_or_add with a missing file.
#

replace_or_add 'missing_file fail' do
  path '/tmp/missingfile'
  pattern 'Does not match'
  line 'add this line'
  ignore_missing false
  ignore_failure true
end

replace_or_add 'missing_file_no_match' do
  path '/tmp/missingfile_no_match'
  pattern 'Does not match'
  line 'add this line'
end

replace_or_add 'missing_file matches_pattern' do
  path '/tmp/missingfile_matches_pattern'
  pattern '^add this'
  line 'add this line'
end

replace_or_add 'missing_file replace_only' do
  path '/tmp/missingfile_replace_only'
  pattern '^add this'
  line 'add this line'
  replace_only true
end
