#
# Copyright 2018 Sous Chefs
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'rspec_helper'
include Line

describe 'expand method' do
  filt = Line::Filter.new
  it 'should not change empty input' do
    expect(filt.expand([])).to eq([])
  end
  it 'should not change a set of only lines' do
    expect(filt.expand(%w(a b))).to eq(%w(a b))
  end
  it 'should insert lines after' do
    expect(filt.expand(['a', Replacement.new('b', %w(c d), :after)])).to eq(%w(a b c d))
  end
  it 'should insert lines before' do
    expect(filt.expand(['a', Replacement.new('b', %w(c d), :before)])).to eq(%w(a c d b))
  end
  it 'should replace line' do
    expect(filt.expand(['a', Replacement.new('b', %w(c d), :replace)])).to eq(%w(a c d))
  end
end
