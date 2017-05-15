#
# Cookbook Name:: line
# Recipe:: tester
#
# Author:: Sean OMeara <someara@chef.io>
# Copyright 2012-2013, 2016 Chef Software, Inc.
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

##################################

# Delete the first entry in a list with delimited entries
delete_from_list 'Delete Operation 1' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '10.0.0.0/8'
end

# # Delete the last entry in a list with delimited entries
delete_from_list 'Delete Operation 2' do
  path '/tmp/dangerfile3'
  pattern 'my @net1918 ='
  delim [', ', '"']
  entry '192.168.0.0/16'
end

delete_from_list 'Delete Operation 3' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Joe'
end

delete_from_list 'Delete Operation 4' do
  path '/tmp/dangerfile3'
  pattern 'People to call:'
  delim [', ']
  entry 'Karen'
end

delete_from_list 'Delete Operation 5' do
  path '/tmp/dangerfile3'
  pattern 'multi = '
  delim [", ", "[", "]"]
  entry '425'
end
#
