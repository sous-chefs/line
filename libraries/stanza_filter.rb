# Filters to massage files

module Line
  class Filter
    def stanza(current, args)
      # Assumes stanzas are named uniquely across the file and contiguous
      # Stanza starts with ^[<name>]$
      # Stanza ends with next stanza or EOF
      # Sets one instance of a key in a stanza to a new value TODO: set last found
      # Example
      # [a1]
      #   att1 = value1
      #   lines in the a1 stanza
      # [a2]
      #   att2 = value2

      # args[0] stanza to select, name of the stanza to match if not there it will be created
      # args[1] {keys, values} to replace or add to the stanza
      # Comment lines will be ignored
      #
      @stanza_pattern = /^\[(?<name>[\w.-_%@]*)\]\s*/ # deal with comments on stanza line
      # set up tests for valid stanza lines
      stanza_name = args[0]
      settings = args[1] # A hash of keywords and values

      stanza_names = find_stanzas(current)
      add_stanza(current, stanza_names, stanza_name) unless stanza_names[stanza_name]
      stanza_settings = parse_stanza(current, stanza_names, stanza_name)
      new_settings = diff_settings(stanza_settings, settings)
      current = update_stanza(current, stanza_names, stanza_name, new_settings)
      expand(current)
    end

    def find_stanzas(current)
      stanza_names = {}
      current.each_index do |i|
        md = @stanza_pattern.match(current[i])
        next unless md
        stanza_names[md[:name]] = i # There might be multiple stanza with the same name
      end
      stanza_names
    end

    def add_stanza(current, stanza_names, stanza_name)
      current << "[#{stanza_name}]"
      stanza_names[stanza_name] = current.size - 1
    end

    def parse_stanza(current, stanza_names, stanza_name)
      # return a hash with keys and values
      settings = {}
      si = stanza_names[stanza_name] + 1
      while si < current.size && current[si] !~ @stanza_pattern
        md = /\s*(?<key>[\w.-_%@]*)\s*=\s*(?<value>.*)\s*/.match(current[si])
        settings[md[:key].to_sym] = { value: md[:value], location: si } if md
        si += 1
      end
      settings
    end

    def diff_settings(stanza_settings, settings)
      diff_values = {}
      settings.each do |s_key, s_value|
        value = s_value unless stanza_settings[s_key.to_sym] && stanza_settings[s_key.to_sym][:value] == s_key
        location = stanza_settings[s_key.to_sym] ? stanza_settings[s_key.to_sym][:location] : nil
        diff_values[s_key.to_sym] = { value: value, location: location }
      end
      diff_values
    end

    def update_stanza(current, stanza_names, stanza_name, settings)
      settings.each do |keyname, attrs|
        if attrs[:location].nil?
          if current[stanza_names[stanza_name]].class == Line::Replacement
            current[stanza_names[stanza_name]].add(["  #{keyname} = #{attrs[:value]}"], :after)
          else
            current[stanza_names[stanza_name]] = Replacement.new(current[stanza_names[stanza_name]], ["  #{keyname} = #{attrs[:value]}"], :after)
          end
        else
          current[attrs[:location]] = Replacement.new(current[attrs[:location]], ["  #{keyname} = #{attrs[:value]}"], :replace)
        end
      end
      current
    end
  end
end
