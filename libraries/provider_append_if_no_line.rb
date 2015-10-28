#
# Cookbook Name:: line
# Library:: provider_append_if_no_such_line
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

class Chef
  class Provider
    class AppendIfNoLine < Chef::Provider
      provides :append_if_no_line if respond_to?(:provides)
      def load_current_resource
      end

      def action_edit
        string = escape_string new_resource.line
        regex = /^#{string}$/

        if ::File.exist?(new_resource.path)
          begin
            f = ::File.open(new_resource.path, 'r+')

            found = false
            f.each_line { |line| found = true if line =~ regex }

            unless found
              f.puts new_resource.line
              new_resource.updated_by_last_action(true)
            end
          ensure
            f.close
          end
        else
          begin
            f = ::File.open(new_resource.path, 'w')
            f.puts new_resource.line
          ensure
            f.close
          end
        end

        def nothing
        end
      end
    end
  end
end
