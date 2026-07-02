# AGENTS.md

## Cookbook Scope

The `line` cookbook does not install or manage upstream software. It exposes Chef custom resources
for editing local files and has no APT, DNF/YUM, Zypper, architecture, or upstream version
availability constraints.

## Known Constraints

* Resources process target files in memory, so very large files can be expensive to edit.
* End-of-line handling is tested with `\n` and `\r\n`; other line endings may behave unexpectedly.
* Missing-file behavior differs by resource and is intentional. Check README examples before
  changing default missing-file handling.

## Policyfile Migration Notes

* Dependency resolution is Policyfile-first. Do not reintroduce `Berksfile` or `berks install`.
* Kitchen suites use named run lists so multi-recipe integration suites keep their previous
  Berkshelf run list behavior.
* `test` and `spectest` are local fixture cookbooks and must remain path dependencies in
  `Policyfile.rb`.
