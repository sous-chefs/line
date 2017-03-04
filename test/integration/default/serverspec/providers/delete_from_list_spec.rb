require 'spec_helper'
require 'json'

describe 'delete_from_list should remove' do
  context 'the last delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/192\.168\.0\.0/) }
    end
  end

  context 'the first delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/192\.168\.0\.0/) }
    end
  end

  context 'the first complex delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/310/) }
    end
  end

  context 'the last complex delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/425/) }
    end
  end

  context 'the first simply delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/Joe/) }
    end
  end

  context 'the last simply delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should_not match(/Joe/) }
    end
  end

  context 'the only delimited entry' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should match(/last_delimited_list= \(\|single\|\)/) }
    end
  end
end
