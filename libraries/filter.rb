# Filters to massage files

# upcoming filters
#  in_stanza - make sure key and value are in a stanza

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

    def replace(current, args)
      # Replace each instance of a pattern line with a  set of lines
      # current is an array of lines
      # args[0] is a pattern to match a line
      # args[1] is an array of lines to replace the matched lines
      #
      # returns array with inserted lines
      match_pattern = args[0]
      insert_lines = args[1]

      # find matching lines  (match object, line #, insert match, insert direction)
      matches = []
      current.each_index { |i| matches << i if current[i] =~ match_pattern }

      matches.each do |match|
        current[match] = Replacement.new(current[match], insert_lines, :replace)
      end
      expand(current)
    end

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

    def ==(other)
      @original == other
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
