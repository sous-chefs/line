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
property :path, String
property :pattern, [String, Regexp]

resource_name :delete_lines

action :edit do
  return if !target_file_exist? && new_resource.ignore_missing
  raise_not_found
  sensitive_default
  eol = default_eol
  regex = new_resource.pattern.is_a?(String) ? /#{new_resource.pattern}/ : new_resource.pattern
  current = target_current_lines

  # remove lines
  new = current.reject { |l| l =~ regex }

  # eol on last line
  new[-1] += eol unless new[-1].to_s.empty?
  current[-1] += eol unless current[-1].to_s.empty?

  file new_resource.path do
    content new.join(eol)
    backup new_resource.backup
    sensitive new_resource.sensitive
    not_if { new == current }
  end
end

action_class do
  include Line::Helper
end
