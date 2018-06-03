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
      #
      # Errors: If the match pattern matches one of the lines to insert
      # the replacement will happen on every converge which can cause
      # the file to grow
      @match_pattern = args[0]
      @insert_lines = args[1]
      @force = args[2] || false
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
