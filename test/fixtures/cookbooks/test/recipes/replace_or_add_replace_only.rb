#
# Test replace_or_add with the replace_only flag set to true
#
#

cookbook_file '/tmp/replace_only' do
  source 'text_file'
end

replace_or_add 'replace_only' do
  path '/tmp/replace_only'
  pattern 'Identical line'
  line 'Replace duplicate lines'
  replace_only true
end

replace_or_add 'replace_only redo' do
  path '/tmp/replace_only'
  pattern 'Identical line'
  line 'Replace duplicate lines'
  replace_only true
end

cookbook_file '/tmp/replace_only_nomatch' do
  source 'text_file'
end

replace_or_add 'replace_only_nomatch' do
  path '/tmp/replace_only_nomatch'
  pattern 'Does not match'
  line 'Replace duplicate lines'
  replace_only true
end

replace_or_add 'replace_only_nomatch redo' do
  path '/tmp/replace_only_nomatch'
  pattern 'Does not match'
  line 'Replace duplicate lines'
  replace_only true
end
