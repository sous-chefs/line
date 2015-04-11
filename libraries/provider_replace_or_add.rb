#
# Cookbook Name:: line
# Library:: provider_replace_or_add
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
    # inherits from Chef::Provider
    class ReplaceOrAdd < Chef::Provider
      def load_current_resource
      end

      # rubocop:disable MethodLength, AbcSize
      def action_edit
        unless ::File.exist?(new_resource.path)
          create_new new_resource.path
          new_resource.updated_by_last_action(true)
          return
        end

        temp_file = check_lines_in new_resource.path
        f = ::File.new(new_resource.path)

        unless ::File.compare(f, temp_file)
          new_resource.updated_by_last_action(true)
          overwrite_original(f, temp_file)
        end
        temp_file.unlink
      end # def action_edit
      # rubocop:enable MethodLength, AbcSize

      private

      # Compare each line in the target file to the given
      # pattern. If the line matches the pattern, then write
      # out the line to the temp file. Otherwise, write the resource's
      # line to the temp file.
      #
      # @return Tempfile
      def check_lines_in(path = new_resource.path)
        temp_file = Tempfile.new('foo')
        ::File.open(path, 'r+').each_line do |line|
          if line.match(new_resource.pattern) &&
             line != "#{new_resource.line}\n"
            temp_file.puts new_resource.line
          else
            temp_file.puts line
          end
        end
        temp_file.close unless temp_file.nil?
        temp_file
      end

      # create a new file
      def create_new(path = new_resource.path)
        nf = ::File.open(path, 'w')
        nf.puts new_resource.line
        rescue ENOENT
          msg = "ERROR: Containing directory does not exist for #{nf.class}"
          Chef::Log.info msg
        ensure
          nf.close unless nf.nil?
      end

      def nothing
      end
    end
  end
end
