#
# Cookbook Name:: line
# Library:: provider_replace_or_add
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

require 'fileutils'
require 'tempfile'

class Chef
  class Provider
    class ReplaceOrAdd < Chef::Provider

      def load_current_resource
      end
      
      def action_edit             
        regex = /#{new_resource.pattern}/
        
        if ::File.exists?(new_resource.path) then
          begin
            f = ::File.open(new_resource.path, "r+")

            file_owner = f.lstat.uid
            file_group = f.lstat.gid
            file_mode = f.lstat.mode
              
            temp_file = Tempfile.new('foo')
            
            modified = false
            found = false

            f.lines.each do |line|
              if line =~ regex then
                found = true
                unless line == new_resource.line << "\n"
                  line = new_resource.line
                  modified = true
                end
              end
              temp_file.puts line
            end

            if (!found && modified) then # "add"!
              temp_file.puts new_resource.line
              modified = true
            end

            f.close

            if modified then
              temp_file.rewind
              FileUtils.copy_file(temp_file.path,new_resource.path)
              FileUtils.chown(file_owner,file_group,new_resource.path)
              FileUtils.chmod(file_mode,new_resource.path)              
              new_resource.updated_by_last_action(true)
            end

          ensure
            temp_file.close
            temp_file.unlink
          end
        else


          begin
            nf = ::File.open(new_resource.path, 'w')            
            nf.puts new_resource.line
            new_resource.updated_by_last_action(true)
          rescue ENOENT
            Chef::Log.info('ERROR: Containing directory does not exist for #{nf.class}')
          ensure
            nf.close
          end
          
        end # if ::File.exists?
      end # def action_edit
      
      def nothing
      end
      
    end
  end
end
