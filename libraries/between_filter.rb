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
      puts
      puts "START #{start_line}"
      puts "END #{end_line}"
      puts
      if start_line && end_line && start_line <= end_line
        insert_lines = missing_lines_between(current, start_line, end_line, insert_array)
        current[start_line] = Replacement.new(current[start_line], insert_lines, :after)
      end
      expand(current)
    end
  end
end
