line Cookbook CHANGELOG
========================

v0.6.2 (2015-07-15)
--------------------
- Catch lines missed by strict patterns
- Add rspec tests for the replace_or_add provider. The existing chefspec tests don't step into the provider code and so don't check the provider functionality.
- Change the Gemfile to reflect the need for berkshelf 3, chefspec v4.2, rspec 3 for the tests.
- Update provider_replace_or_add to handle cases where the pattern does not match the replacement line.
- Fix notification problem where updated_by_last_action was set when nothing changed.

v0.6.1 (2015-02-24)
--------------------
- Adding CHANGELOG
- Adding ChefSpec matchers
