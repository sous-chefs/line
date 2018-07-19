#
# Copyright 2017, Sous Chefs
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :backup, [true, false], default: false
property :eol, String
property :ignore_missing, [true, false], default: true
property :line, String
property :path, String

resource_name :append_if_no_line

action :edit do
  raise_not_found
  sensitive_default
  eol = default_eol
  add_line = chomp_eol(new_resource.line)
  string = Regexp.escape(add_line)
  regex = /^#{string}$/
  current = target_current_lines

  file new_resource.path do
    content((current + [add_line + eol]).join(eol))
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { ::File.exist?(new_resource.path) && !current.grep(regex).empty? }
  end
end

action_class do
  include Line::Helper
end
