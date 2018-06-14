control 'filter_lines - Verify the code to use filters. Verify several example filters' do
  eol = os.family == 'windows' ? "\r\n" : "\n"

  # do nothing
  describe file('/tmp/dangerfile') do
    its(:content) { should match(/^HELLO THERE I AM DANGERFILE.*last line#{eol}$/m) }
  end
  describe file_ext('/tmp/dangerfile') do
    its('size_lines') { should eq 5 }
  end

  # reverse the characters in each line
  describe file('/tmp/reverse') do
    its(:content) { should match(/OLLEH#{eol}/) }
    its(:content) { should match(/^enil tsal#{eol}/) }
  end

  describe file('/tmp/after') do
    its(:content) { should match(/HELLO THERE I AM DANGERFILE#{eol}line1#{eol}line2#{eol}line3#{eol}# UN/m) }
    its(:content) { should match(/COMMENT ME AND I STOP YELLING I PROMISE#{eol}line1#{eol}line2#{eol}line3#{eol}int/m) }
  end
  describe file_ext('/tmp/after') do
    its('size_lines') { should eq 11 }
  end

  describe file('/tmp/after_first') do
    its(:content) { should match(/HELLO THERE I AM DANGERFILE#{eol}line1#{eol}line2#{eol}line3#{eol}# UN/m) }
    its(:content) { should match(/COMMENT ME AND I STOP YELLING I PROMISE#{eol}int/m) }
  end
  describe file_ext('/tmp/after_last') do
    its('size_lines') { should eq 8 }
  end

  describe file('/tmp/after_last') do
    its(:content) { should match(/HELLO THERE I AM DANGERFILE#{eol}# UNCOMMENT/m) }
    its(:content) { should match(/COMMENT ME AND I STOP YELLING I PROMISE#{eol}line1#{eol}line2#{eol}line3#{eol}int/m) }
  end
  describe file_ext('/tmp/after_last') do
    its('size_lines') { should eq 8 }
  end

  describe file('/tmp/before') do
    its(:content) { should match(/line1#{eol}line2#{eol}line3#{eol}HELLO THERE/m) }
    its(:content) { should match(/line1#{eol}line2#{eol}line3#{eol}COMMENT ME/m) }
  end
  describe file_ext('/tmp/before') do
    its('size_lines') { should eq 11 }
  end

  describe file('/tmp/before_first') do
    its(:content) { should match(/line1#{eol}line2#{eol}line3#{eol}HELLO THERE/m) }
    its(:content) { should match(/FOOL#{eol}COMMENT ME/m) }
  end
  describe file_ext('/tmp/before_first') do
    its('size_lines') { should eq 8 }
  end

  describe file('/tmp/before_last') do
    its(:content) { should match(/^HELLO THERE/m) }
    its(:content) { should match(/line1#{eol}line2#{eol}line3#{eol}COMMENT ME/m) }
  end
  describe file_ext('/tmp/before_last') do
    its('size_lines') { should eq 8 }
  end

  describe file('/tmp/between') do
    between_match = Regexp.escape("empty_list=#{eol}add line#{eol}empty_delimited_list=()#{eol}")
    its(:content) { should match(/#{between_match}/m) }
  end
  describe file_ext('/tmp/between') do
    its('size_lines') { should eq 21 }
  end

  describe file('/tmp/comment') do
    its(:content) { should match(/# last_list/) }
  end
  describe file_ext('/tmp/comment') do
    its('size_lines') { should eq 20 }
  end

  describe file('/tmp/delete_between') do
    its(:content) { should_not match(/^kernel/) }
  end
  describe file('/tmp/delete_between') do
    its(:content) { should match(/crashkernel/) }
  end
  describe file_ext('/tmp/delete_between') do
    its('size_lines') { should eq 18 }
  end

  describe file('/tmp/multiple_filters') do
    its(:content) { should match(/HELLO THERE I AM DANGERFILE#{eol}line1#{eol}line2#{eol}line3#{eol}/m) }
    its(:content) { should match(/COMMENT ME AND I STOP YELLING I PROMISE#{eol}line1#{eol}line2#{eol}line3#{eol}int/m) }
    its(:content) { should_not match(/# UNCOMMENT/) }
  end
  describe file_ext('/tmp/multiple_filters') do
    its('size_lines') { should eq 10 }
  end

  describe file('/tmp/replace') do
    its(:content) { should match(/line1#{eol}line2#{eol}line3#{eol}/) }
    its(:content) { should match(/# UNCOMMENT ME YOU FOOL#{eol}line1#{eol}line2#{eol}line3#{eol}/) }
  end
  describe file_ext('/tmp/replace') do
    its('size_lines') { should eq 9 }
  end

  describe file('/tmp/stanza') do
    its(:content) { should match(/lowercase-names = false/) }
    its(:content) { should match(/addme = option/) }
    its(:content) { should match(/mscldap-timeout = 5/) }
  end
  describe file_ext('/tmp/stanza') do
    its('size_lines') { should eq 26 }
  end

  describe file('/tmp/substitute') do
    its(:content) { should match(/start_list/) }
  end
  describe file_ext('/tmp/substitute') do
    its('size_lines') { should eq 20 }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Insert lines after match redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Insert lines before match redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Change lines between matches redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Change matching lines to comments redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Delete lines between matches redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Replace the matched line redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Change stanza values redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Substitute string for matching pattern redo.*n/) }
  end

  describe file('/tmp/chef_resource_status') do
    its(:content) { should match(/Multiple before and after match redo.*n/) }
  end
end
