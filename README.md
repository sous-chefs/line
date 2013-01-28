# line cookbook

# Motivation
Quite often, the need arises to do line editing instead of managing an
entire file with a template resource. This cookbook supplies various 
resources that will help you do this.

# Usage
Add "depends 'line'" to your cookbook's metadata.rb to gain access to
the resoures.

    append_if_no_line "example 1" do
      path "/tmp/dangerfile"
      line "HI THERE I AM STRING"
    end

    replace_or_add "ipv4 localhost hosts entry" do
      path "/etc/hosts"
      pattern "Why hello there.*"
      line "Why hello there you beautiful person, you."
    end

# Notes
So far, the only resource implemented are 

* append_if_no_line

Planned future resources will include:

* append_if_no_lines
* comment_lines_matching
* uncomment_lines_matching
* delete_lines_matching

# Recipes
tester -  A recipe to exercise the resources

# Author
Author:: Sean OMeara (<someara@opscode.com>)
