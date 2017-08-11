if defined?(ChefSpec)
  custom_resources = {
    add_to_list: [:edit],
    append_if_no_line: [:edit],
    delete_from_list: [:edit],
    delete_lines: [:edit],
    replace_or_add: [:edit],
  }

  custom_resources.each do |resource, actions|
    actions.each do |action|
      ChefSpec.define_matcher resource
      define_method("#{action}_#{resource}") do |message|
        ChefSpec::Matchers::ResourceMatcher
          .new(resource.to_sym, action, message)
      end
    end
  end
end
