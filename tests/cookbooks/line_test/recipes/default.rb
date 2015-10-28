#
# Cookbook Name:: line
# Recipe:: tester
#
# Author:: Sean OMeara <someara@chef.io>
# Copyright 2012-2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##################################
# files to edit
##################################

file '/tmp/dangerfile' do
  action :create
  owner 'root'
  mode '00644'
  content 'HELLO THERE I AM DANGERFILE
# UNCOMMENT ME YOU FOOL
COMMENT ME AND I STOP YELLING I PROMISE
int main(void){ for i=0; i<100; i++ };'
end

file '/tmp/dangerfile2' do
  action :create_if_missing
  owner 'root'
  mode '00666'
  content '# authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADA1F45ADMVN24QFL123LPPEQWERWWEWO keepme@yourfile
ssh-rsa AAAAB3NzaC1yc2EAAAADDEADBEEFDERPDERPDERPILIKESSHTOO skelator@grayskull
ssh-rsa AAAAB3NzaC1yc2EAAAADAKHASDKJHSDKHASDHK1231235KJASD0 keepmetoo@yourfile'
end

file '/tmp/dangerfile3' do
  action :create
  owner 'root'
  mode '00666'
  content 'my @net1918 = ("10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16");
People to call: Joe, Bobby, Karen
multi = ([310], [818], [425])'
end
cookbook_file '/tmp/serial.conf' do
  owner 'root'
  mode '00644'
end

##################################

append_if_no_line 'Operation 1' do
  path '/tmp/dangerfile'
  line 'HI THERE I AM STRING'
end

replace_or_add 'Operation 2' do
  path '/tmp/dangerfile'
  pattern 'hey there.*'
  line 'hey there how you doin'
end

replace_or_add 'Operation 3' do
  path '/tmp/dangerfile'
  pattern 'hey there.*'
  line 'hey there how you doin'
end

replace_or_add 'Operation 4' do
  path '/tmp/dangerfile2'
  pattern 'ssh-rsa AAAAB3NzaC1yc2EAAAADDEADBEEF.*'
  line ''
end

delete_lines 'Operation 5' do
  path '/tmp/dangerfile'
  pattern '^HI.*'
end

delete_lines 'Operation 6' do
  path '/tmp/dangerfile2'
  pattern '^#.*'
end
delete_from_list 'Operation 7' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', "\""]
  entry '192.168.0.0/16'
end

delete_from_list 'Operation 8' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', "\""]
  entry '10.0.0.0/8'
end

delete_from_list 'Operation 9' do
  path '/tmp/dangerfile3'
  pattern 'multi ='
  delim [', ', '[', ']']
  entry '310'
end

delete_from_list 'Operation 10' do
  path '/tmp/dangerfile3'
  pattern 'multi ='
  delim [', ', '[', ']']
  entry '425'
end

delete_from_list 'Operation 11' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Joe'
end

delete_from_list 'Operation 12' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Karen'
end

add_to_list 'Operation 13' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', "\""]
  entry '33.33.33.0/24'
end

add_to_list 'Operation 14' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Harry'
end

# add_to_list 'Operation 15' do
#   path '/tmp/dangerfile3'
#   pattern 'multi '
#   delim [", ", "[", "]"]
#   entry "323"
# end

# add_to_list 'Operation 16' do
#   path '/tmp/dangerfile3'
#   pattern 'my @net1918 ='
#   delim [", ", "\""]
#   entry "172.16.0.0/12"
# end

# add_to_list 'Operation 17' do
#   path '/tmp/dangerfile3'
#   pattern 'People to call:'
#   delim [", "]
#   entry "Bobby"
# end

# add_to_list 'Operation 18' do
#   path '/tmp/dangerfile3'
#   pattern 'multi '
#   delim [", ", "[", "]"]
#   entry "818"
# end
