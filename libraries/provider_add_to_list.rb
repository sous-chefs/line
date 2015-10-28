#
# Cookbook Name:: line
# Library:: provider_add_to_list
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

require 'fileutils'
require 'tempfile'

class Chef
  class Provider
    class AddToList < Chef::Provider

      provides :add_to_list if respond_to?(:provides)
      
      def load_current_resource
      end

      def action_edit
        regex = /#{new_resource.pattern}/

        if ::File.exist?(new_resource.path)
          begin
            f = ::File.open(new_resource.path, 'r+')

            file_owner = f.lstat.uid
            file_group = f.lstat.gid
            file_mode = f.lstat.mode

            temp_file = Tempfile.new('foo')

            modified = false

            f.each_line do |line|
              if line =~ regex
                found = true
                if new_resource.delim.count == 1
                  unless line =~ /(#{new_resource.delim[0]}|#{new_resource.pattern})\s*#{new_resource.entry}\s*(#{new_resource.delim[0]}|\n)/
                    line = line.chomp + "#{new_resource.delim[0]}#{new_resource.entry}"
                    modified = true
                  end
                else
                  unless line =~ /#{new_resource.delim[0]}\s*#{new_resource.entry}\s*#{new_resource.delim[1]}/
                    line = line.chomp + "#{new_resource.delim[0]}#{new_resource.entry}#{new_resource.delim[1]}"
                    modified = true
                  end
                            end
              end
              temp_file.puts line
            end

            f.close

            if modified
              temp_file.rewind
              FileUtils.copy_file(temp_file.path, new_resource.path)
              FileUtils.chown(file_owner, file_group, new_resource.path)
              FileUtils.chmod(file_mode, new_resource.path)
              new_resource.updated_by_last_action(true)
            end

          ensure
            temp_file.close
            temp_file.unlink
          end
        end # if ::File.exists?
      end # def action_edit

      def nothing
      end
    end
  end
end
