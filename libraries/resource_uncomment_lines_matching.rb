#
# Cookbook Name:: line
# Library:: resource_uncomment_lines_matching
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

class Chef
  class Resource
    class UncommentLinesMatching < Chef::Resource

      def initialize(name, run_context=nil)
        super
        @resource_name = :uncomment_lines_matching
        @action = :uncomment
        @allowed_actions.push(:uncomment)
      end

      def path(arg=nil)
        set_or_return(
          :path,
          arg,
          :kind_of => String
          )
      end

      def line(arg=nil)
        set_or_return(
          :regex,
          arg,
          :kind_of => Regexp
          )
      end

    end
  end
end
