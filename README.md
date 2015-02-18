# line cookbook

# Motivation
Quite often, the need arises to do line editing instead of managing an
entire file with a template resource. This cookbook supplies various 
resources that will help you do this.

# Usage
Add "depends 'line'" to your cookbook's metadata.rb to gain access to
the resoures.

    append_if_no_line "make sure a line is in dangerfile" do
      path "/tmp/dangerfile"
      line "HI THERE I AM STRING"
    end
    
    replace_or_add "spread the love" do
      path "/some/file"
      pattern "Why hello there.*"
      line "Why hello there, you beautiful person, you."
    end

    delete_lines "remove hash-comments from /some/file" do
      path "/some/file"
      pattern "^#.*"
    end

    add_to_list "add entry to a list"
      path "/some/file"
      pattern "People to call: "
      delim [","]
      entry "Bobby"
    end


# Notes
So far, the only resource implemented are 

    append_if_no_line
    replace_or_add
    delete_lines
    add_to_list

  add_to_list
    delim must be an array of 1 or 2 muli-character elements.
      If one delimiter is given, it is assumed that either the delimiter or the given search pattern will proceed each entry and
      each entry will be followed by either the delimeter or a new line character:
	  delim [","]
          People to call: Joe, Bobby, Karen
          People to call: Joe, Karen, Bobby
          People to call: Bobby, Joe, Karen
	   
      If two delimiters are given, they will suround each entry. For Example:
	  delim ["(,",",)"]
          People to call: (,Joe,)(,Bobby,)(,Karen,)
	        

More to follow.

# Recipes
tester -  A recipe to exercise the resources

# Author
Author:: Sean OMeara (<someara@chef.io>)
