#
# Copyright 2018 Sous Chefs
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

# Filter to replace matched lines
module Line
  class Filter
    def replace(current, args)
      # Replace each instance of a pattern line with a  set of lines
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[1] is a string or an array of lines to replace the matched lines
      # args[2] Force to allow the change even though it will probably break something
      #
      # returns array with inserted lines
      #
      # Errors: If the match pattern matches one of the lines to insert
      # the replacement will happen on every converge which can cause
      # the file to grow
      @match_pattern = verify_kind(args[0], Regexp)
      @insert_lines = [verify_kind(args[1], [Array, String])].flatten
      @force = verify_kind(args[2], [TrueClass, FalseClass, NilClass]) || false
      verify_insert_lines

      matches = []
      current.each_index { |i| matches << i if current[i] =~ @match_pattern }

      matches.each do |match|
        current[match] = Replacement.new(current[match], @insert_lines, :replace)
      end

      expand(current)
    end

    def verify_insert_lines
      @insert_lines.each do |line|
        raise ArgumentError, 'Warning - Replacement line should not match the replace pattern' if line =~ @match_pattern && !@force
      end
    end
  end
end
