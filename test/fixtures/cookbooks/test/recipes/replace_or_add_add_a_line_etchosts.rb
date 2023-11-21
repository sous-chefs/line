#
# Add a line that exactly matches the specified pattern.
#

replace_or_add 'add_a_line_matching_pattern_etchosts' do
  path '/etc/hosts'
  pattern '# Add etchosts line'
  line '# Add etchosts line'
end
