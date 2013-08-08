#
# Cookbook Name:: line
# Recipe:: tester
#
# Author:: Sean OMeara <someara@opscode.com>
# Copyright 2012-2013, Opscode, Inc.
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

execute "woot" do
  command "echo woot"
  action :nothing
end

cookbook_file "/tmp/dangerfile" do
  owner "root"
  mode "00644"
  notifies :run, "execute[woot]"
end

cookbook_file "/tmp/dangerfile2" do
  owner "root"
  mode "00666"
  notifies :run, "execute[woot]"
  action :create_if_missing
end

cookbook_file "/tmp/serial.conf" do
  owner "root"
  mode "00644"
  notifies :run, "execute[woot]"
end

##################################

append_if_no_line "example 1" do
  path "/tmp/dangerfile"
  line "HI THERE I AM STRING"
end

replace_or_add "example 2" do
  path "/tmp/dangerfile"
  pattern "hey there.*"
  line "hey there how you doin"
end

replace_or_add "example 3" do
  path "/tmp/dangerfile"
  pattern "hey there.*"
  line "hey there how you doin"
end

replace_or_add "example 4" do
  path "/tmp/dangerfile2"
  pattern "ssh-rsa AAAAB3NzaC1yc2EAAAADDEADBEEF.*"
  line ""
end
