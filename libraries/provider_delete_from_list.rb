#
# Cookbook Name:: line
# Library:: provider_delete_from_list
#
# Author:: Antek S. Baranski <antek.baranski@gmail.com>
#
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
    class DeleteFromList < Chef::Provider

      provides :delete_from_list if respond_to?(:provides)

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

            regexdelim = []
            new_resource.delim.each do |delim|
              regexdelim << escape_regex(delim)
            end

            f.each_line do |line|
              if line =~ regex
                case new_resource.delim.count
                when 1
                  case line
                  when /#{regexdelim[0]}\s*#{new_resource.entry}/
                    line = line.sub(/#{regexdelim[0]}\s*#{new_resource.entry}/, '')
                    line = line.chomp
                    modified = true
                  when /#{new_resource.entry}\s*#{regexdelim[0]}/
                    line = line.sub(/#{new_resource.entry}\s*#{regexdelim[0]}/, '')
                    line = line.chomp
                    modified = true
                  end
                when 2
                  case line
                  when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
                    line = line.sub(/#{regexdelim[0]}\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/, '')
                    line = line.chomp
                    modified = true
                  when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
                    line = line.sub(/#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}\s*#{regexdelim[0]}/, '')
                    line = line.chomp
                    modified = true
                  end
                when 3
                  case line
                  when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
                    line = line.sub(/#{regexdelim[0]}\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/, '')
                    line = line.chomp
                    modified = true
                  when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
                    line = line.sub(/#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}\s*#{regexdelim[0]}/, '')
                    line = line.chomp
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
