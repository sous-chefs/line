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

# extends Chef class
class Chef
  # extends Provider class
  class Provider
    # inherits from Chef::Provider
    class DeleteLines < Chef::Provider
      def load_current_resource
      end

      def action_edit
        regex = /#{new_resource.pattern}/

        return unless ::File.exist?(new_resource.path)
        begin
          f = ::File.open(new_resource.path, 'r+')
          temp_file = Tempfile.new('foo')

          f.each_line do |line|
            next if line =~ regex
            temp_file.puts line
          end

          write_original(f, temp_file) if ::File.compare(f, temp_file)
        ensure
          temp_file.close unless temp_file.nil?
          f.close unless f.nil?

          temp_file.unlink
        end
      end # def action_edit

      def action_nothing
      end
    end
  end
end
