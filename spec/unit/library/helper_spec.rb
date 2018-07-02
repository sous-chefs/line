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

describe 'chomp_eol method' do
  before(:each) do
    @method_test = Class.new
    @method_test.extend(Line::Helper)
    allow(@method_test).to receive(:new_resource).and_return(double('new_resource', eol: "\n"))
  end

  it 'should remove trailing eol' do
    expect(@method_test.chomp_eol("line\n")).to eq('line')
  end

  it 'should raise error with embedded eol' do
    expect { @method_test.chomp_eol("embedded\ninline") }.to raise_error(ArgumentError)
  end
end
