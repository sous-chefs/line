# line cookbook
[![Build Status](https://www.travis-ci.org/sous-chefs/line-cookbook.svg?branch=master)](https://www.travis-ci.org/sous-chefs/line-cookbook)

# Motivation
Quite often, the need arises to do line editing instead of managing an
entire file with a template resource. This cookbook supplies various 
resources that will help you do this.

# Usage
Add "depends 'line'" to your cookbook's metadata.rb to gain access to
the resoures.

```ruby
append_if_no_line "make sure a line is in some file" do
  path "/some/file"
  line "HI THERE I AM STRING"
end

replace_or_add "why hello" do
  path "/some/file"
  pattern "Why hello there.*"
  line "Why hello there, you beautiful person, you."
end

delete_lines "remove hash-comments from /some/file" do
  path "/some/file"
  pattern "^#.*"
end

delete_lines "remove hash-comments from /some/file with a regexp" do
  path "/some/file"
  pattern /^#.*/
end

replace_or_add "change the love, don't add more" do
  path "/some/file"
  pattern "Why hello there.*"
  line "Why hello there, you beautiful person, you."
  replace_only true
end

add_to_list "add entry to a list" do
  path "/some/file"
  pattern "People to call: "
  delim [","]
  entry "Bobby"
end

delete_from_list "delete entry from a list" do
  path "/some/file"
  pattern "People to call: "
  delim [","]
  entry "Bobby"
end
```

# Notes
So far, the only resources implemented are 

```ruby
append_if_no_line
replace_or_add
delete_lines
add_to_list
delete_from_list
```

## add_to_list
delim must be an array of 1, 2 or 3 multi-character elements.
If one delimiter is given, it is assumed that either the delimiter or the given search pattern will proceed each entry and
each entry will be followed by either the delimeter or a new line character:
People to call: Joe, Bobby
delim [","]
entry 'Karen'
People to call: Joe, Bobby, Karen

If two delimiters are given, the first is used as the list element delimiter and the second as entry delimiters:
my @net1918 = ("10.0.0.0/8", "172.16.0.0/12");
delim [", ", "\""]
entry "192.168.0.0/16"
my @net1918 = ("10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16");
    
if three delimiters are given, the first is used as the list element delimiter, the second as the leading entry delimiter and the third as the trailing delimiter:
multi = ([310], [818])
delim [", ", "[", "]"]
entry "425"
multi = ([310], [818], [425])

end_with is an optional property. If specified a list is expected to end with the given string.
    
## delete_from_list
Works exactly the same way as `add_to_list`, see above.
	        
More to follow.

# Author
Author:: Sean OMeara (<sean@sean.io>)
Contributor:: Antek S. Baranski (<antek.baranski@gmail.com>)
