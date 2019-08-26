#
# Copyright:: 2019 Sous Chefs
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Line
  # Helper methods to use in the list manipulation resources
  module ListHelper
    def insert_list_entry(current)
      new = []
      ends_with = new_resource.ends_with ? Regexp.escape(new_resource.ends_with) : ''
      regex = /#{new_resource.pattern}.*#{ends_with}/
      current.each do |line|
        new << line
        line = line.dup
        next unless line =~ regex
        if new_resource.ends_with
          list_end = line.rindex(new_resource.ends_with)
          seperator = line =~ /#{new_resource.pattern}.*\S.*#{ends_with}/ ? new_resource.delim[0] : ''
          case new_resource.delim.count
          when 1
            next if line =~ /(#{regexdelim[0]}|#{new_resource.pattern})\s*#{new_resource.entry}\s*(#regexdelim[0]|#{ends_with})/
            line = line.insert(list_end, "#{seperator}#{new_resource.entry}")
          when 2
            next if line =~ /#{regexdelim[1]}#{new_resource.entry}\s*#{regexdelim[1]}/
            line = line.insert(list_end, "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[1]}")
          when 3
            next if line =~ /#{regexdelim[1]}#{new_resource.entry}\s*#{regexdelim[2]}/
            line = line.insert(list_end, "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[2]}")
          end
        else
          seperator = line =~ /#{new_resource.pattern}.*\S.*$/ ? new_resource.delim[0] : ''
          case new_resource.delim.count
          when 1
            next if line =~ /((#{regexdelim[0]})*|#{new_resource.pattern})\s*#{new_resource.entry}(#{regexdelim[0]}|\n)/
            line += "#{seperator}#{new_resource.entry}"
          when 2
            next if line =~ /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
            line += "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[1]}"
          when 3
            next if line =~ /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
            line += "#{seperator}#{new_resource.delim[1]}#{new_resource.entry}#{new_resource.delim[2]}"
          end
        end
        Chef::Log.error("New line: #{line}")
        new[-1] = line
      end
      new
    end

    def delete_list_entry(current)
      new = []
      ends_with = new_resource.ends_with ? Regexp.escape(new_resource.ends_with) : ''
      regex = /#{new_resource.pattern}.*#{ends_with}/
      current.each do |line|
        line = line.dup
        new << line
        next unless line =~ regex
        case new_resource.delim.count
        when 1
          case line
          when /#{regexdelim[0]}\s*#{new_resource.entry}/
            # remove the entry
            line = line.sub(/(#{regexdelim[0]})*\s*#{new_resource.entry}(#{regexdelim[0]}|\s*$)/, new_resource.delim[0])
            # delete any trailing delimeters
            line = line.sub(/\s*(#{regexdelim[0]})*\s*$/, '')
          when /#{new_resource.entry}\s*#{regexdelim[0]}/
            line = line.sub(/#{new_resource.entry}(#{regexdelim[0]})*/, '')
          end
        when 2
          case line
          when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}/
            line = line.sub(/(#{regexdelim[0]})*\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[1]}(#{regexdelim[0]})*/, '')
          end
        when 3
          case line
          when /#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}/
            line = line.sub(/(#{regexdelim[0]})*\s*#{regexdelim[1]}#{new_resource.entry}#{regexdelim[2]}(#{regexdelim[0]})*/, '')
          end
        end
        new[-1] = line
        Chef::Log.info("New line: #{line}")
      end
      new
    end

    def regexdelim
      @regexdelim || escape_delims
    end

    def escape_delims
      # Search for escaped delimeters. Add the raw delimiters to the lines.
      @regexdelim = []
      new_resource.delim.each do |delim|
        @regexdelim << Regexp.escape(delim)
      end
      @regexdelim
    end
  end
end
