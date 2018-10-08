# line Cookbook CHANGELOG

## v2.1.1 (2018-10-08)
- Allow the backup option to be specified as true

## v2.1.0 (2018-09-28)
- Add the filter_lines resource
- Add the after filter method to allow lines to be inserted after matching a line

## v2.0.2 (2018-06-29)
- Explicitly disallow embedded EOL characters in replacement and append lines

## v2.0.1 (2018-06-01)

- Tested on chef 12.13.37.  Fix error caused by using the sensitive attribute.  Sensitive true will always be used for chef 12.

## v2.0.0 (2018-05-19)

- _Breaking change_ - Files are processed in memory instead of line by line. It's possible that large files that were previously updated by the line cookbook will not be able to be processed.
- _Breaking change_ - Drop Chef 12 support
- Use template files instead of `cookbook_file` so that we get platform sensitive line endings written for testing.
- Add windows support to `add_to_list`, `append_if_no_line`, `delete_from_list`, `delete_lines`, `replace_or_add`.
- Make the processing of missing target files consistent. Add the `ignore_missing` property to the resources to allow a missing file to raise an error.
- Clean up the order of some boiler plate code.
- Create helper methods for some common resource functions.
- Drop the OS helpers in favour os using `platform_family?`.

## v1.2.0 (2018-04-18)

- Add the ignore_missing option to the `delete_lines` and `delete_from_list`. Don't raise an error if the target file is missing.

## v1.1.1 (2018-04-16)

- Allow appending to an empty file.

## v1.1.0 (2018-03-26)

- Rework `delete_lines` to use file provider sub-resource.
- Support matching with regexps in addition to strings with `delete_lines`.
- Rework `append_if_no_line` to use file provider sub-resource.
- Fix edge conditions around `files-with-no-trailing-CR` being fed to `append_if_no_line`.
- Remove library helpers.
- Remove the `escape_regexp` and escape_string methods in favour of native `Regexp.escape`

## v1.0.6 (2018-03-23)

- Add question mark to regular expression escape characters

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
