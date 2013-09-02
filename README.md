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

# Notes
So far, the only resource implemented are 

    append_if_no_line.
    replace_or_add

More to follow.

# Recipes
tester -  A recipe to exercise the resources

# Author
Author:: Sean OMeara (<someara@opscode.com>)
