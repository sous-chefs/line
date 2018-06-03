# Filter to insert lines after a match
module Line
  class Filter
    def after(current, args)
      # Insert a set of lines immediately after each match of the pattern
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[1] is an array of lines to insert after the matched lines
      # args[2] match instance, each, first, last
      #
      # returns array with inserted lines
      match_pattern = args[0]
      insert_array = args[1]
      select_match = args[2] || :each

      # find matching lines  (match object, line #, insert match, insert direction)
      matches = []
      current.each_index { |i| matches << i if current[i] =~ match_pattern }

      case select_match
      when :each
        matches.each_index do |i|
          next_match = matches[i + 1] || current.size
          insert_lines = missing_lines_between(current, matches[i], next_match, insert_array)
          current[matches[i]] = Replacement.new(current[matches[i]], insert_lines, :after)
        end
      when :first
        if matches.any?
          next_match = matches[2] || current.size
          match = matches.first
          insert_lines = missing_lines_between(current, match, next_match, insert_array)
          current[match] = Replacement.new(current[match], insert_lines, :after)
        end
      when :last
        if matches.any?
          next_match = current.size
          match = matches.last
          insert_lines = missing_lines_between(current, match, next_match, insert_array)
          current[match] = Replacement.new(current[match], insert_lines, :after)
        end
      end
      expand(current)
    end
  end
end
