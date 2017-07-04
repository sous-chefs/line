# Custom inspec resources

These inspec resources were written to facilitate converting rspec unit tests to inspec integration tests. The resources may be shared by including an inspec.yml profile that specifies

```ruby
depends:
  - name: line_resources
    path: ../line_resources
```

The test directory structure should be:

../integration -line_resources inspec.yml profile for the line custom inspec resources -controls dummy control<br>
-libraries custom resources -test_suite_name inspec.yml profile for the specific test suite -controls test suite inspec tests
