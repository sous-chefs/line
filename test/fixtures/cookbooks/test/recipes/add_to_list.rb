# setup
file '/tmp/dangerfile3' do
  action :create
  owner 'root'
  mode '00666'
  content 'my @net1918 = ("10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16");
People to call: Joe, Bobby, Karen
multi = ([310], [818], [425])
DEFAULT_APPEND="resume=/dev/sda2 splash=silent crashkernel=256M-:128M showopts"
empty_list=
empty_delimited_list=()
empty_3delim=()
last_list=
last_delimited_list= (|single|)
wo2d_empty=
wo2d_list="first2","second2"
wo3d_empty=
wo3d_list=[first3],[second3]'
end

# add first entry. 1 delim, ends_with
add_to_list 'Add to list 1' do
  path '/tmp/dangerfile3'
  pattern 'empty_list='
  delim [' ']
  entry 'newentry'
end

# # add an entry to a existing list. 1 delim, ends_with
add_to_list 'Add to DEFAULT_APPEND' do
  path '/tmp/dangerfile3'
  pattern 'DEFAULT_APPEND='
  delim [' ']
  ends_with '"'
  entry 'showopts'
end

# add an entry to a existing list. 1 delim, ends_with
add_to_list 'Add to DEFAULT_APPEND again' do
  path '/tmp/dangerfile3'
  pattern 'DEFAULT_APPEND='
  delim [' ']
  ends_with '"'
  entry 'addtogrub'
end

# add first entry. 2 delim, ends_with
add_to_list 'Add to list using Regexp escaped input' do
  path '/tmp/dangerfile3'
  pattern Regexp.escape('empty_delimited_list=(')
  delim [', ', '"']
  ends_with ')'
  entry 'newentry'
end

# # add existing entry. 2 delim, ends_with
# add_to_list 'Operation 19' do
#   path '/tmp/dangerfile3'
#   pattern Regexp.escape('last_delimited_list= (')
#   delim [',', '|']
#   ends_with ')'
#   entry 'single'
# end
#
# # Add existing entry list. 2 delim, ends_with
# add_to_list 'Operation 20' do
#   path '/tmp/dangerfile3'
#   pattern 'my @net1918 ='
#   delim [', ', '"']
#   ends_with ');'
#   entry '172.16.0.0/12'
# end
#
# # Add new entry to a non empty list. 2 delim, ends_with
# add_to_list 'Operation 21' do
#   path '/tmp/dangerfile3'
#   pattern 'my @net1918 ='
#   delim [', ', '"']
#   ends_with ');'
#   entry '33.33.33.0/24'
# end
#
# # add first entry. 3 delim, ends_with
# add_to_list 'Operation 22' do
#   path '/tmp/dangerfile3'
#   pattern Regexp.escape('empty_3delim=(')
#   delim [', ', '[', ']']
#   ends_with ')'
#   entry 'newentry'
# end
#
# # add existing entry. 3 delim, ends_with
# add_to_list 'Operation 23' do
#   path '/tmp/dangerfile3'
#   pattern 'multi '
#   delim [', ', '[', ']']
#   ends_with ')'
#   entry '818'
# end
#
# # add new entry to non-empty list. 3 delim, ends_with
# add_to_list 'Operation 24' do
#   path '/tmp/dangerfile3'
#   pattern 'multi '
#   delim [', ', '[', ']']
#   ends_with ')'
#   entry '323'
# end
#
# # add first entry. 1 delim
# add_to_list 'Operation 25' do
#   path '/tmp/dangerfile3'
#   pattern 'last_list='
#   delim [' ']
#   entry 'single'
# end
#
# # add existing entry. 1 delim
# add_to_list 'Operation 26' do
#   path '/tmp/dangerfile3'
#   pattern 'People to call:'
#   delim [', ']
#   entry 'Bobby'
# end
#
# # add a new entry. 1 delim
# add_to_list 'Operation 27' do
#   path '/tmp/dangerfile3'
#   pattern 'People to call:'
#   delim [', ']
#   entry 'Harry'
# end
#
# # add first entry. 2 delim
# add_to_list 'Operation 28' do
#   path '/tmp/dangerfile3'
#   pattern 'wo2d_empty='
#   delim [',', '"']
#   entry 'single'
# end
#
# # add existing entry. 2 delim
# add_to_list 'Operation 29' do
#   path '/tmp/dangerfile3'
#   pattern 'wo2d_list'
#   delim [',', '"']
#   entry 'first2'
# end
#
# # add a new entry. 2 delim
# add_to_list 'Operation 30' do
#   path '/tmp/dangerfile3'
#   pattern 'wo2d_list'
#   delim [',', '"']
#   entry 'third2'
# end
#
# # add first entry. 3 delim
# add_to_list 'Operation 31' do
#   path '/tmp/dangerfile3'
#   pattern 'wo3d_empty='
#   delim [',', '[', ']']
#   entry 'single'
# end
#
# # add existing entry. 3 delim
# add_to_list 'Operation 32' do
#   path '/tmp/dangerfile3'
#   pattern 'wo3d_list'
#   delim [',', '[', ']']
#   entry 'first3'
# end
#
# # add a new entry. 3 delim
# add_to_list 'Operation 33' do
#   path '/tmp/dangerfile3'
#   pattern 'wo3d_list'
#   delim [',', '[', ']']
#   entry 'third3'
# end
