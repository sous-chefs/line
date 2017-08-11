cookbook_file '/tmp/dangerfile3' do
  owner 'root'
  mode '00644'
end

# test lists with an item seperator
add_to_list 'Add to an empty list, seperator' do
  path '/tmp/dangerfile3'
  pattern 'empty_list='
  delim [' ']
  entry 'newentry'
end

# test lists with an item seperator and terminal list string
add_to_list 'Add an existing item a list, seperator, terminal' do
  path '/tmp/dangerfile3'
  pattern 'DEFAULT_APPEND='
  delim [' ']
  ends_with '"'
  entry 'showopts'
end

add_to_list 'Add a new item to a list, seperator, terminal' do
  path '/tmp/dangerfile3'
  pattern 'DEFAULT_APPEND='
  delim [' ']
  ends_with '"'
  entry 'addtogrub'
end

# test lists with an item seperator, item delimiters
# test lists with an item seperator, item delimiters and a terminal list string

# test lists with an item seperator, before and after item delimiters

# test lists with an item seperator, before and after item delimiters and a terminal list string
add_to_list 'Add to list using Regexp escaped input' do
  path '/tmp/dangerfile3'
  pattern Regexp.escape('empty_delimited_list=(')
  delim [', ', '"']
  ends_with ')'
  entry 'newentry'
end
