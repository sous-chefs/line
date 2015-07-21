#
# Cookbook Name:: line
# Library:: resource_add_to_list
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
  class Resource
    class AddToList < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :add_to_list
        @action = :edit
        @allowed_actions.push(:edit, :nothing)
      end

      def path(arg = nil)
        set_or_return(
          :path,
          arg,
          kind_of: String
        )
      end

      def pattern(arg = nil)
        set_or_return(
          :pattern,
          arg,
          kind_of: String
        )
      end

      def delim(arg = nil)
        set_or_return(
          :delim,
          arg,
          kind_of: Array
        )
      end

      def entry(arg = nil)
        set_or_return(
          :entry,
          arg,
          kind_of: String
        )
      end
    end
  end
end
