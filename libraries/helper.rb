module Line
  module Helper
    def chomp_eol(line)
      fixed = line.chomp(new_resource.eol)
      raise ArgumentError, "Line #{line} has embedded EOL characters, not allowed for this resource" if fixed =~ /#{new_resource.eol}/
      fixed
    end

    def default_eol
      new_resource.eol = platform_family?('windows') ? "\r\n" : "\n" unless property_is_set?(:eol)
      new_resource.eol
    end

    def raise_not_found
      raise "File #{new_resource.path} not found" unless target_file_exist? || new_resource.ignore_missing
    end

    def sensitive_default
      new_resource.sensitive = true unless property_is_set?(:sensitive)
    rescue ArgumentError
      # chef 12 raises ArgumentError checking property_is_set?
      new_resource.sensitive = true
    end

    def target_current_lines
      target_file_exist? ? ::File.binread(new_resource.path).split(new_resource.eol) : []
    end

    def target_file_exist?
      @target_file_exist ||= ::File.exist?(new_resource.path)
    end
  end
end
