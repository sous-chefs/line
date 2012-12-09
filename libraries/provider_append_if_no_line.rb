#
# Cookbook Name:: line
# Library:: provider_append_if_no_such_line
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
  class Provider
    class AppendIfNoLine < Chef::Provider

      def load_current_resource
      end

      def escape_string(string)
        pattern = /(\'|\"|\.|\*|\/|\-|\\|\(|\))/
        string.gsub(pattern){|match|"\\" + match}
      end
      
      def action_append
        f = Chef::Util::FileEdit.new(new_resource.path)
        g = f.dup

        regex = escape_string new_resource.line
        regex = "^#{regex}$"
        
        f.insert_line_if_no_match(/#{regex}/,new_resource.line)
        f.write_file

        # UGLY hack. How can I avoid this?
        # All I need to do is figure out if the file has changed or not.
        # maybe change contents from private to protected in
        # Chef::Util::FileEdit ?        
        if f.inspect.split('@')[3] != g.inspect.split('@')[3] then
          new_resource.updated_by_last_action(true)
        end
      end

    end
  end
end
