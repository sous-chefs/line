# Filter to replace matched lines
module Line
  class Filter
    def replace(current, args)
      # Replace each instance of a pattern line with a  set of lines
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[1] is an array of lines to replace the matched lines
      #
      # returns array with inserted lines
      match_pattern = args[0]
      insert_lines = args[1]
      # TODO protect against match pattern matching any of the insert_lines
      # Will insert with every run

      # find matching lines  (match object, line #, insert match, insert direction)
      matches = []
      current.each_index { |i| matches << i if current[i] =~ match_pattern }

      matches.each do |match|
        current[match] = Replacement.new(current[match], insert_lines, :replace)
      end
      expand(current)
    end
  end
end
