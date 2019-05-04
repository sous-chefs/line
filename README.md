# line cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/line.svg)](https://supermarket.chef.io/cookbooks/line)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/line/master.svg)](https://circleci.com/gh/sous-chefs/line)
[![pullreminders](https://pullreminders.com/badge.svg)](https://pullreminders.com?ref=badge)

## Motivation

Quite often, the need arises to do line editing instead of managing an entire file with a template resource. This cookbook supplies various resources that will help you do this.

## Limitations

- The line resources processes the entire target file in memory. Trying to edit large files may fail.
- The end of line processing was only tested using `\n` and `\r\n`. Using other line endings very well may not work.
- The end of line string used needs to match the actual end of line used in the file `\n` and `\r\n` are used as the defaults but if they don't match the actual end of line used in the file the results will be weird.
- Adding a line implies there is a separator on the previous line. Adding a line differs from appending characters.
- Lines to be added should not contain EOL characters. The providers do not do multiline regex checks.
- Missing file processing is the way it is by intention

  - `add_to_list` do nothing, list not found so there is nothing to add to.
  - `append_if_no_line` create file, add the line.
  - `delete_from_list` do nothing, the list was not found which implies there is nothing to delete
  - `delete_lines` do nothing, the line isn't there which implies there is nothing to delete
  - `replace_or_add` create file, add the line
  - `filter_lines` create file if the file changes

- Chef client version 13 or greater is expected.

## Resources

For more detailed information see the matching resource documentation:

- [append_if_no_line](https://github.com/sous-chefs/line/blob/master/documentation/resources/add_to_list.md) - Add a missing line
- [replace_or_add](https://github.com/sous-chefs/line/blob/master/documentation/resources/replace_or_add.md) - Replace a line that matches a pattern or add a missing line
- [delete_lines](https://github.com/sous-chefs/line/blob/master/documentation/resources/delete_lines.md) - Delete an item from a list
- [add_to_list](https://github.com/sous-chefs/line/blob/master/documentation/resources/add_to_list.md) - Add an item to a list
- [delete_from_list](https://github.com/sous-chefs/line/blob/master/documentation/resources/delete_from_list.md) - Delete lines that match a pattern
- [filter_lines](https://github.com/sous-chefs/line/blob/master/documentation/resources/filter_lines.md) - Supply a ruby proc or use a sample filter to edit lines.
  The filter_lines resource supports multiple line modfications.

  Sample filters:
  - after: Insert lines after a matched line
  - before: Insert lines before a matched lined
  - between: Insert lines between matched lines
  - comment: Change lines to comments
  - delete_between: Delete the lines found between two patterns
  - missing: Add missing lines to a file
  - replace: Replace each instance of matched lines
  - stanza: Insert or change keys in files formatted in stanzas
  - substitute: Substitute text in lines matching a pattern

## Authors

- Contributor: Mark Gibbons
- Contributor: Dan Webb
- Contributor: Sean OMeara
- Contributor: Antek S. Baranski

## Contributors

This project exists thanks to all the people who contribute.
<img src="https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false" /></a>


### Backers

Thank you to all our backers! 🙏 [[Become a backer](https://opencollective.com/sous-chefs#backer)]
<a href="https://opencollective.com/sous-chefs#backers" target="_blank"><img src="https://opencollective.com/sous-chefs/backers.svg?width=890"></a>

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [[Become a sponsor](https://opencollective.com/sous-chefs#sponsor)]
<a href="https://opencollective.com/sous-chefs/sponsor/0/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/1/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/2/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/3/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/4/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/5/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/6/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/7/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/8/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/sous-chefs/sponsor/9/website" target="_blank"><img src="https://opencollective.com/sous-chefs/sponsor/9/avatar.svg"></a>
