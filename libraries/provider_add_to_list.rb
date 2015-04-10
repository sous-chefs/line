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

# extend Chef class
class Chef
  # extend Provider class
  class Provider
    # define AddToList, which extends Chef::Provider
    class AddToList < Chef::Provider
      def load_current_resource
      end

      def action_edit
        return unless ::File.exist?(new_resource.path)

        begin
          f = ::File.open(new_resource.path, 'r+')

          # setting these local variables here so the lines containing
          # regex's, below, can be shortened
          delim = [new_resource.delim[0], new_resource.delim[1]]
          entry = new_resource.entry
          pattern = new_resource.pattern

          temp_file = Tempfile.new('foo')

          f.lines.each do |line|
            unless line.match pattern
              temp_file.puts line
              next
            end

            line.chomp!
            if new_resource.delim.count == 1
              regex = /(#{delim[0]}|#{pattern})\s*#{entry}\s*(#{delim[0]}|\n)/
              line += "#{delim[0]}#{entry}" unless line =~ regex
            else
              regex = /#{delim[0]}\s*#{entry}\s*#{delim[1]}/
              line += "#{delim[0]}#{entry}#{delim[1]}" unless line =~ regex
            end
            temp_file.puts line
          end
        ensure
          temp_file.close unless temp_file.nil?
          f.close unless f.nil?
          temp_file.unlink
        end

        unless ::File.cmp(f, temp_file)
          overwrite_original(f, temp_file)
          new_resource.updated_by_last_action(true)
        end
      end # def action_edit

      def nothing
      end
    end
  end
end
