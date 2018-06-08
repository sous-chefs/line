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

property :path, String
property :filters, [Array]
# Array of filters and argument arrays
# [ {code: proc or method, args: [] } ]
property :filter, [Method, Proc, Array]
property :filter_args, Array
property :ignore_missing, [true, false], default: true
property :backup, [true, false], default: false
property :eol

resource_name :filter_lines

action :edit do
  new_resource.sensitive = true unless property_is_set?(:sensitive)
  eol = default_eol

  current = ::File.exist?(new_resource.path) ? ::File.binread(new_resource.path).split(eol) : []
  new = current.clone

  # Proc or Method
  if new_resource.filter.is_a?(Method) || new_resource.filter.is_a?(Proc)
    new = new_resource.filter.call(new, new_resource.filter_args)
  end

  # Filters
  #   { code: proc or method , args: [] }
  if new_resource.filters
    new_resource.filters.each do |filter|
      if filter[:code].is_a?(Method) || filter[:code].is_a?(Proc)
        new = filter[:code].call(new, filter[:args])
      end
    end
  end

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
