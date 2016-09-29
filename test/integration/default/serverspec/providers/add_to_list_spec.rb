require 'spec_helper'
require 'json'

describe 'add_to_list should add entries' do
  context 'to lists of delimited entries' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should match(Regexp.new(Regexp.escape('my @net1918 = ("172.16.0.0/12", "33.33.33.0/24");'))) }
    end
  end

  context 'to lists of simple entries' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should match(Regexp.new(Regexp.escape('People to call: Bobby, Harry'))) }
    end
  end

  context 'to lists of of complex delimited entries' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should match(Regexp.new(Regexp.escape('multi = ([818], [323])'))) }
    end
  end

  context 'to list with an end character' do
    describe file('/tmp/dangerfile3') do
      its(:content) { should match(Regexp.new(Regexp.escape('DEFAULT_APPEND="resume=/dev/sda2 splash=silent crashkernel=256M-:128M showopts addtogrub"'))) }
    end
  end
end
