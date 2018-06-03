# Filter to substitute in lines that  match
module Line
  class Filter
    def substitute(current, args)
      # current is an array of lines
      # args[0] is a pattern to match a line or a string in a line
      # args[1] is the string to replace the sub pattern with
      # args[2] is a pattern to match and substitute for, defaults to arg[0]
      # args[3] ignore the safety check about repeated changes to a line
      #
      # returns array with inserted lines
      #
      # error condition - If the substitute string will match a line after replacement
      #  it is possible for the file size to increase after every converge. Use force
      # to ignore the possible error.
      match_pattern = args[0]
      substitute_str = args[1]
      sub_pattern = args[2] || match_pattern
      force = args[3] | false

      # find lines matching the pattern, then substitute
      current.each_index do |i|
        current[i].gsub!(sub_pattern, substitute_str) if current[i] =~ match_pattern
        raise ArgumentError, "Warning - The line at offset #{i} with contents #{current[i] will match each chef run" if current[i] =~ sub_pattern && !force
      end
      current
    end
  end
end
