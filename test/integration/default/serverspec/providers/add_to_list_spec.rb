require 'spec_helper'
require 'json'

describe 'add_to_list should add entries' do
  context 'to list that ends_with' do
    context 'to lists with seperator delimiters' do
      context 'add new item and existing item' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(/#{Regexp.escape('DEFAULT_APPEND="resume=/dev/sda2 splash=silent crashkernel=256M-:128M showopts addtogrub"')}/) }
        end
      end

      context 'to empty list' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(/#{Regexp.escape('empty_list=newentry')}/) }
        end
      end
    end

    context 'to lists with seperator and entry delimiters' do
      context 'add existing entry and new entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(/#{Regexp.escape('my @net1918 = ("172.16.0.0/12", "33.33.33.0/24");')}/) }
        end
      end

      context 'add entry that already exists' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(/#{Regexp.escape('last_delimited_list= (|single|)')}/) }
        end
      end

      context 'to empty delimited list' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('empty_delimited_list=("newentry")'))) }
        end
      end
    end

    context 'to lists with seperator, start and end delimiters' do
      context 'add entry to an empty list' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(/#{Regexp.escape('empty_3delim=([newentry])')}/) }
        end
      end

      context 'add existing entry to a list' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('multi = ([818], [323])'))) }
        end
      end

      context 'to lists of of complex delimited entries' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('multi = ([818], [323])'))) }
        end
      end
    end
  end

  context 'to list without ends_with' do
    context 'to lists with seperator' do
      context 'add first entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('last_list=single'))) }
        end
      end

      context 'add existing and new entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('People to call: Bobby, Harry'))) }
        end
      end
    end

    context 'to lists with seperator, entry delimiters' do
      context 'add first entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('wo2d_empty="single"'))) }
        end
      end

      context 'add existing and new entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('wo2d_list="first2","second2","third2"'))) }
        end
      end
    end

    context 'to lists with seperator, start and end delimiters' do
      context 'add first entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('wo3d_empty=[single]'))) }
        end
      end

      context 'add existing and new entry' do
        describe file('/tmp/dangerfile3') do
          its(:content) { should match(Regexp.new(Regexp.escape('wo3d_list=[first3],[second3],[third3]'))) }
        end
      end
    end
  end
end
