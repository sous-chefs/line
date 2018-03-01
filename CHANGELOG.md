# line Cookbook CHANGELOG

## v1.0.5 (2018-02-20)

- Minor Testing updates
- Remove custom matchers for ChefSpec. ChefDK 1 versions of ChefSpec will no longer work when unit testing against this cookbook.

## v1.0.4 (2018-01-10)

- Handle deleting items from a list using spaces as the delimeter

## v1.0.3 (2017-08-22)

- Add edge case tests for `add_to_list`
- Handle the `delete_lines`, `add_to_list`, and `delete_from_list` resources when a missing file is specified.

## v1.0.2 (2017-07-07)

- Fix #58 Add resource locator matchers
- Fix #59 Add resource matcher tests
- Make cookstyle 2.0.0 fixes
- Delete the unused minitest files
- Clean up the `file_ext` inspec resource

## v1.0.1 (2017-07-05)

- Fix #53 `append_if_no_line` appends line always appends

## v1.0.0 (2017-06-13)

- Move cookbook to Sous-Chefs org
- Move to using custom resources

## v0.6.3 (2015-10-27)

- Fixing Ruby and Chef deprecation warnings
- Cleaning up tests a bit
- Adding support for `source_url` and `issues_url`
- `delete_from_list` resource

## v0.6.2 (2015-07-15)

- Catch lines missed by strict patterns
- Add rspec tests for the `replace_or_add` provider. The existing chefspec tests don't step into the provider code and so don't check the provider functionality.
- Change the Gemfile to reflect the need for berkshelf 3, chefspec v4.2, rspec 3 for the tests.
- Update `provider_replace_or_add` to handle cases where the pattern does not match the replacement line.
- Fix notification problem where `updated_by_last_action` was set when nothing changed.

## v0.6.1 (2015-02-24)

- Adding CHANGELOG
- Adding ChefSpec matchers
