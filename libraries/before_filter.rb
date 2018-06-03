# Filter to insert lines before a match
module Line
  class Filter
    def before(current, args)
      # Insert a set of lines before a match of the pattern.
      # Inserts only the missing lines
      # Lines are missing if not between matches of the pattern
      # Inserts do not care about the order of the lines
      #   :first insert any lines not found (start -> match line) before the first match
      #   :last insert any lines not found (match.last -1 -> match.last line) before the last match
      #   :each insert any lines not found (start -> match & match -1 -> match line) before each match
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[1] is an array of lines to insert before the matched lines
      # args[2] match instance, each, first, last
      #
      # returns array with inserted lines
      match_pattern = args[0]
      insert_array = args[1]
      select_match = args[2] || :each

      # find lines matching the pattern
      matches = []
      current.each_index { |i| matches << i if current[i] =~ match_pattern }

      case select_match
      when :each
        previous = 0
        matches.each do |match|
          insert_lines = missing_lines_between(current, previous, match, insert_array)
          current[match] = Replacement.new(current[match], insert_lines, :before)
          previous = match + 1
        end
      when :first
        if matches.any?
          previous = 0
          match = matches.first
          insert_lines = missing_lines_between(current, previous, match, insert_array)
          current[match] = Replacement.new(current[match], insert_lines, :before)
        end
      when :last
        if matches.any?
          previous = matches[-2] || 0
          match = matches.last
          insert_lines = missing_lines_between(current, previous, match, insert_array)
          current[match] = Replacement.new(current[match], insert_lines, :before)
        end
      end
      expand(current)
    end
  end
end
