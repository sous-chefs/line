#
# Cookbook Name:: line
# Library:: provider_delete_lines
#
# Author:: Sean OMeara <someara@chef.io>
# Author:: Jeff Blaine <jblaine@kickflop.net>
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
    class DeleteLines < Chef::Provider
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
                modified = true
              else
                temp_file.puts line
              end
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
        end # ::File.exists
      end # def action_edit

      def action_nothing
      end
    end
  end
end
