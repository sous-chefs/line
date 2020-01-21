#
# cookbook::test
#
# Test the replace_or_add resource.
# Remove duplicate lines
#

template '/tmp/no_duplicate_double' do
  source 'text_file.erb'
end

template '/tmp/no_duplicate_single' do
  source 'text_file.erb'
end

template '/tmp/no_duplicate_replace_only' do
  source 'text_file.erb'
end

replace_or_add 'no_duplicate' do
  path '/tmp/no_duplicate_double'
  pattern 'Identical line'
  line 'Remove duplicate lines'
  remove_duplicates true
end

replace_or_add 'no_duplicate redo' do
  path '/tmp/no_duplicate_double'
  pattern 'Identical line'
  line 'Remove duplicate lines'
  remove_duplicates true
end

replace_or_add 'no_duplicate single line' do
  path '/tmp/no_duplicate_single'
  pattern 'Data line'
  line 'Remove duplicate lines'
  remove_duplicates true
end

replace_or_add 'no_duplicate_replace_only' do
  path '/tmp/no_duplicate_replace_only'
  replace_only true
  pattern 'Identical line'
  line 'Remove duplicate lines'
  remove_duplicates true
end
