require 'spec_helper'
require 'json'

describe 'append_if_no_line should add line' do
  context 'add when no matching line' do
    describe file('/tmp/dangerfile') do
      its(:content) { should match(/HI THERE I AM STRING/) }
    end
  end
end
