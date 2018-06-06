directory '/tmp'

# ==================== Inline proc filters =================

template '/tmp/dangerfile' do
end

filter_lines 'Do nothing' do
  path '/tmp/dangerfile'
  filter proc { |current| current }
end

template '/tmp/reverse' do
  source 'dangerfile.erb'
end

filter_lines 'Reverse line text' do
  path '/tmp/reverse'
  filter proc { |current| current.map(&:reverse) }
end

# ==================== after filter =================

filters = Line::Filter.new
insert_lines = %w(line1 line2 line3)
match_pattern = /^COMMENT ME|^HELLO/

# ==================== after filter =================

template '/tmp/after' do
  source 'dangerfile.erb'
end

filter_lines 'Insert lines after match' do
  path '/tmp/after'
  filter filters.method(:after)
  filter_args [match_pattern, insert_lines]
end

filter_lines 'Insert lines after match redo' do
  path '/tmp/after'
  filter filters.method(:after)
  filter_args [match_pattern, insert_lines]
end

template '/tmp/after_first' do
  source 'dangerfile.erb'
end

filter_lines 'Insert lines after first match' do
  path '/tmp/after_first'
  filter filters.method(:after)
  filter_args [match_pattern, insert_lines, :first]
end

template '/tmp/after_last' do
  source 'dangerfile.erb'
end

filter_lines 'Insert lines after last match' do
  path '/tmp/after_last'
  filter filters.method(:after)
  filter_args [match_pattern, insert_lines, :last]
end

# ==================== before filter =================

template '/tmp/before' do
  source 'dangerfile.erb'
  sensitive true
end

template '/tmp/before_first' do
  source 'dangerfile.erb'
  sensitive true
end

template '/tmp/before_last' do
  source 'dangerfile.erb'
  sensitive true
end

filter_lines 'Insert lines before match' do
  path '/tmp/before'
  sensitive false
  filter filters.method(:before)
  filter_args [match_pattern, insert_lines]
end

filter_lines 'Insert lines before match' do
  path '/tmp/before_first'
  sensitive false
  filter filters.method(:before)
  filter_args [match_pattern, insert_lines, :first]
end

filter_lines 'Insert lines last match' do
  path '/tmp/before_last'
  sensitive false
  filter filters.method(:before)
  filter_args [match_pattern, insert_lines, :last]
end

filter_lines 'Insert lines before match redo' do
  path '/tmp/before'
  sensitive false
  filter filters.method(:before)
  filter_args [match_pattern, insert_lines]
end

# ==================== between filter =================
template '/tmp/between' do
  source 'dangerfile3.erb'
end

filter_lines 'Change lines between matches' do
  path '/tmp/between'
  sensitive false
  filter filters.method(:between)
  filter_args [/^empty/, /last_list/, ['add line']]
end

filter_lines 'Change lines between matches redo' do
  path '/tmp/between'
  sensitive false
  filter filters.method(:between)
  filter_args [/$empty/, /last_list/, ['add line']]
end

# ==================== comment filter =================
template '/tmp/comment' do
  source 'dangerfile3.erb'
end

filter_lines 'Change matching lines to comments' do
  path '/tmp/comment'
  sensitive false
  filter filters.method(:comment)
  filter_args [/last_list/]
end

filter_lines 'Change matching lines to comments redo' do
  path '/tmp/comment'
  sensitive false
  filter filters.method(:comment)
  filter_args [/last_list/]
end

# ==================== replace filter =================

template '/tmp/replace' do
  source 'dangerfile.erb'
  sensitive true
end

filter_lines 'Replace the matched line' do
  path '/tmp/replace'
  filter filters.method(:replace)
  filter_args [match_pattern, insert_lines]
end

filter_lines 'Replace the matched line redo' do
  path '/tmp/replace'
  filter filters.method(:replace)
  filter_args [match_pattern, insert_lines]
end

# ==================== stanza filter =================
template '/tmp/stanza' do
  source 'stanza.erb'
end

filter_lines 'Change stanza values' do
  path '/tmp/stanza'
  sensitive false
  filters(
    [
      { code: filters.method(:stanza),
        args: ['libvas', { 'use-dns-srv' => false, 'mscldap-timeout' => 5 }],
      },
      { code: filters.method(:stanza),
        args: ['nss_vas', { 'lowercase-names' => false, addme: 'option' }],
      },
    ]
  )
end

filter_lines 'Change stanza values redo' do
  path '/tmp/stanza'
  filters(
    [
      { code: filters.method(:stanza),
        args: ['libvas', { 'use-dns-srv' => false, 'mscldap-timeout' => 5 }],
      },
      { code: filters.method(:stanza),
        args: ['nss_vas', { 'lowercase-names' => false, addme: 'option' }],
      },
    ]
  )
end

# ==================== substitute filter =================
template '/tmp/substitute' do
  source 'dangerfile3.erb'
end

filter_lines 'Substitute string for matching pattern' do
  path '/tmp/substitute'
  filter filters.method(:substitute)
  filter_args [/last_list/, 'start_list']
end

filter_lines 'Substitute string for matching pattern redo' do
  path '/tmp/substitute'
  filter filters.method(:substitute)
  filter_args [/last_list/, 'start_list']
end

# ==================== Multiple filters =================

template '/tmp/multiple_filters' do
  source 'dangerfile.erb'
  sensitive true
end

filter_lines 'Multiple before and after match' do
  path '/tmp/multiple_filters'
  sensitive false
  filters(
    [
      # insert lines before the last match
      { code: filters.method(:before),
        args: [match_pattern, insert_lines, :last],
      },
      # insert lines after the last match
      { code: filters.method(:after),
        args: [match_pattern, insert_lines, :last],
      },
      # delete comment lines
      { code: proc { |current| current.select { |line| line !~ /^#/ } },
      },
    ]
  )
end

filter_lines 'Multiple before and after match redo' do
  path '/tmp/multiple_filters'
  sensitive false
  filters(
    [
      # insert lines before the last match
      { code: filters.method(:before),
        args: [match_pattern, insert_lines, :last],
      },
      # insert lines after the last match
      { code: filters.method(:after),
        args: [match_pattern, insert_lines, :last],
      },
      # delete comment lines
      { code: proc { |current| current.select { |line| line !~ /^#/ } },
      },
    ]
  )
end

# =====================

file '/tmp/emptyfile' do
  content ''
end

filter_lines 'Do nothing to the empty file' do
  path '/tmp/emptyfile'
  filter proc { |current| current }
end
