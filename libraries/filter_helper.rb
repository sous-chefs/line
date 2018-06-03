# Common filter methods and useful classes
module Line
  class Filter
    def missing_lines_between(current, start, match, ia)
      # find lines in ia that are between the start and end of the lines array
      ib = ia.dup
      lines = current.slice(start, match - start)
      lines.each do |line|
        match_line = ib.index(line)
        ib[match_line] = nil if match_line
      end
      ib.compact
    end

    def expand(lines)
      new_lines = []
      lines.each do |line|
        # note - want to do *lines to add them instead adding an array
        new_lines.push line.class == Replacement ? line.insert : line
      end
      new_lines.flatten # add the lines better so we don't need this
    end
  end

  class Replacement
    def initialize(original, additional, direction)
      @original = original.dup
      @additional = additional
      @direction = direction # replace, before, after
    end

    def insert
      case @direction
      when :after
        [@additional].unshift(@original)
      when :before
        [@additional].push(@original)
      when :replace
        [@additional]
      else
        [@original]
      end
    end

    def add(lines, direction)
      case direction
      when :after
        @additional.push(lines)
      when :before
        @additional.push(@original)
      when :replace
        @additional = lines
      end
    end
  end
end
