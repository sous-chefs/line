if defined?(ChefSpec)
  ChefSpec.define_matcher :add_to_list
  def edit_add_to_list(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:add_to_list, :edit, resource)
  end

  ChefSpec.define_matcher :append_if_no_line
  def edit_append_if_no_line(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:append_if_no_line, :edit, resource)
  end

  ChefSpec.define_matcher :delete_lines
  def edit_delete_lines(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:delete_lines, :edit, resource)
  end

  ChefSpec.define_matcher :replace_or_add
  def edit_replace_or_add(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:replace_or_add, :edit, resource)
  end
end
