if defined?(ChefSpec)

  def edit_add_to_list(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:add_to_list, :edit, resource)
  end

  def edit_append_if_no_line(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:append_if_no_line, :edit, resource)
  end

  def edit_delete_lines(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:delete_lines, :edit, resource)
  end

  def edit_replace_or_add(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:replace_or_add, :edit, resource)
  end
end
