# frozen_string_literal: true

name 'line'

run_list 'test::default'

cookbook 'line', path: '.'
cookbook 'spectest', path: './spec/fixtures/cookbooks/spectest'
cookbook 'test', path: './test/cookbooks/test'

{
  'default' => ['test::default'],
  'add-to-list' => %w(
    test::add_to_list_1d
    test::add_to_list_1d_terminal
    test::add_to_list_2d
    test::add_to_list_2d_terminal
    test::add_to_list_3d
    test::add_to_list_3d_terminal
    test::add_to_list_empty
  ),
  'append-if-no-line' => %w(
    test::append_if_no_line_empty
    test::append_if_no_line_single_line
    test::append_if_no_line_template
  ),
  'delete-from-list' => %w(
    test::delete_from_list_1d
    test::delete_from_list_2d
    test::delete_from_list_3d
    test::delete_from_list_empty
  ),
  'delete-lines' => %w(
    test::delete_lines_empty
    test::delete_lines_regexp
    test::delete_lines_string
  ),
  'filter-lines' => %w(
    test::filter_lines_after
    test::filter_lines_before
    test::filter_lines_between
    test::filter_lines_comment
    test::filter_lines_delete_between
    test::filter_lines_inline
    test::filter_lines_multi
    test::filter_lines_misc
    test::filter_lines_replace
    test::filter_lines_replace_between
    test::filter_lines_stanza
    test::filter_lines_substitute
  ),
  'replace-or-add' => %w(
    test::replace_or_add_add_a_line_matching_pattern
    test::replace_or_add_change_line_eof
    test::replace_or_add_duplicate
    test::replace_or_add_missing_file
    test::replace_or_add_replace_only
    test::replace_or_add_manage_symlink_source
  ),
}.each do |suite, recipes|
  named_run_list suite, recipes
end
