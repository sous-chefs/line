# Filter to comment lines that  match
module Line
  class Filter
    def comment(current, args)
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[2] match instance, each, first, last
      #
      # returns array with inserted lines
      match_pattern = args[0]
      @comment_str = args[1] || '#'
      @comment_space = args[2] || ' '

      # find lines matching the pattern
      current.each_index do |i|
        if current[i] =~ match_pattern
          next if commented?(current[i])
          current[i] = mark_as_comment(current[i])
        end
      end
      current
    end

    def commented?(line)
      line =~ /^\s*#{@comment_str}/
    end

    def mark_as_comment(line)
      "#{@comment_str}#{@comment_space}#{line}"
    end
  end
end
