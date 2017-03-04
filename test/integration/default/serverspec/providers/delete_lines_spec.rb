require 'spec_helper'
require 'json'

describe 'delete_lines should remove' do
  context 'multiple lines when the pattern matches' do
    describe file('/tmp/dangerfile1') do
      its(:content) { should_not match(/^HI/) }
    end
  end

  context 'a single line when specified multiple times' do
    describe file('/tmp/dangerfile1') do
      its(:content) { should_not match(/^#/) }
    end
  end

  context 'the first line in the file when matched' do
    describe file('/tmp/dangerfile2') do
      its(:content) { should_not match(/^#/) }
    end
  end
end
