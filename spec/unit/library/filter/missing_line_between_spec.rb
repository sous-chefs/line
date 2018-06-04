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

describe 'missing_lines_betweeen method' do
  filt = Line::Filter.new
  ia = %w(line1 line2 line3)
  current = %w(c1 c1 c1)
  allthere = %w(line3 line2 line1 c1 line3 line2 c1 line1 c1)
  it 'should return all lines missing for empty current input' do
    expect(filt.missing_lines_between([], 0, 0, ia)).to eq(ia)
  end
  it 'should return missing lines before first match' do
    expect(filt.missing_lines_between(current, 0, 1, ia)).to eq(ia)
  end
  it 'should return empty array before first match' do
    expect(filt.missing_lines_between(allthere, 0, 3, ia)).to eq([])
  end
  it 'should return missing lines before second match' do
    expect(filt.missing_lines_between(allthere, 4, 6, ia)).to eq(%w(line1))
  end
  it 'should return missing lines before third match' do
    expect(filt.missing_lines_between(allthere, 7, 8, ia)).to eq(%w(line2 line3))
  end
end
