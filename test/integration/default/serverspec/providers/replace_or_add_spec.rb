require 'spec_helper'
require 'json'

describe 'replace or add should add line' do
  context 'add when no matching line' do
    describe file('/tmp/dangerfile') do
      its(:content) { should match(/hey there how you doin/) }
      # Check number of occurances
      its(:content) { should_not match(/ssh-rsa/) }
    end
  end
end
