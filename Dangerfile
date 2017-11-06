# Reference: http://danger.systems/reference.html

def code_changes?
  code = %w[libraries attributes recipes resources]
  code.each do |location|
    return true unless git.modified_files.grep(/#{location}/).empty?
  end
  return false
end

def test_changes?
  tests = %w[spec test .kitchen.yml .kitchen.dokken.yml]
  tests.each do |location|
    return true unless git.modified_files.grep(/#{location}/).empty?
  end
end

fail 'Please provide a summary of your Pull Request.' if github.pr_body.length < 10

fail 'Please add labels to this Pull Request' if github.pr_labels.empty?

warn 'This is a big Pull Request.' if git.lines_of_code > 400

# Require a CHANGELOG entry for non-test changes.
if !git.modified_files.include?('CHANGELOG.md') && code_changes?
  fail('Please include a [CHANGELOG](https://github.com/sous-chefs/line-cookbook/blob/master/CHANGELOG.md) entry.')
end

# A sanity check for tests.
if git.lines_of_code > 5 && code_changes? && !test_changes?
  warn 'This Pull Request is probably missing tests.'
end
