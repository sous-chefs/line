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

# Filter to insert lines between two matches
module Line
  class Filter
    def between(current, args)
      # Insert a set of lines between lines matching two patterns
      # current is an array of lines
      # args[0] is a pattern. Insert lines after this pattern
      # args[1] is a pattern. Insert lines before this pattern
      # args[2] is an array of lines to insert after the matched lines
      #
      # returns array with inserted lines
      # Does the order of matches matter?
      first_pattern = args[0]
      second_pattern = args[1]
      insert_array = args[2]

      # find matching lines  (match object, line #, insert match, insert direction)
      first_matches = []
      second_matches = []
      current.each_index do |i|
        first_matches << i if current[i] =~ first_pattern
        second_matches << i if current[i] =~ second_pattern
      end

      start_line = first_matches.first
      end_line = second_matches.last
      if start_line && end_line && start_line <= end_line
        insert_lines = missing_lines_between(current, start_line, end_line, insert_array)
        current[start_line] = Replacement.new(current[start_line], insert_lines, :after)
      end
      expand(current)
    end
  end
end
