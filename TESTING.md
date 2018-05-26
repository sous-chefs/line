
### Cookbook Testing Guidelines

Each Sous Chefs cookbook is setup for both local testing and testing within automated test platforms. The line cookbook utilizes Rspec, Chefspec, Cookstyle, Foodcritic, and Test Kitchen for cookbook testing. On a local workstation Test Kitchen will run via kitchen-vagrant against VirtualBox systems. Within Travis CI we utilize kitchen-dokken to test in Docker containers. Within Appveyor we use Appveyor supplied windows images to test windows servers. Dangerfile processing is used to verify content in the pull request.

Prior to submitting your change you should run all tests. Linting (Cookstyle/Foodcritic) and Unit (Rspec) tests can be run by running delivery local all or by running each command. Test kitchen tests can be run by running kitchen test. Test Kitchen tests may take quite some time to complete depending on the level of coverage and systems involved. You may want to run kitchen list and test against a sub-set of a total suites.

Any new functionality should include additional testing to protect against future regressions. Similarly, patches that fix a bug or regression should have a regression test. Simply put, this is a test that would fail without your patch but passes with it. The goal is to ensure this bug doesn’t regress in the future. Consider a regular expression that doesn’t match a certain pattern that it should, so you provide a patch and a test to ensure that the part of the code that uses this regular expression works as expected. Later another contributor may modify this regular expression in a way that breaks your use cases. The test you wrote will fail, signaling to them to research your ticket and use case and accounting for it.

In practical terms unit tests for new library modules are usually written using rspec. Integration tests are written using inspec. Edge cases are important for the line cookbook so detailed tests are appreciated. 

If you need help writing tests, please ask on the Sous Chef channel of the Chef Community Slack.

### Local Testing Check List

- [ ] rspec 
  *  Runs the rspec unit tests including the chefspec tests
- [ ] cookstyle -a 
  *  Check and possibly change to match the cookstyle ruby style
- [ ] foodcritic . 
  *  Check against the foodcritic rules
- [ ] test kitchen 
  *  Integration tests to use the resources. Please run the ubuntu-16.04 tests as the minimum acceptable level of testing. 

### Github Pull Request Testing Check List

- [ ] Circleci runs Dangerfile tests
  *  Test kitchen on ubuntu linux versions
- [ ] Appveyor tests
  *  Test kitchen on Windows 2012r2
- [ ] Travis tests
  *  Test kitchen on centos and ubuntu linux versions
  *  Unit tests using rspec
  *  Lint tests using foodcritic and cookstyle
