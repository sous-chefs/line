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
require 'ostruct'

class Method_Tester
  include Line::Helper
  def new_resource
    OpenStruct.new(eol: "\n")
  end
end

describe 'embedded_eol method' do
  before(:each) do
    @method_test = Method_Tester.new
  end

  it 'should remove trailing eol' do
    expect(@method_test.embedded_eol("line\n")).to eq('line')
  end

  it 'should raise error with embedded eol' do
    expect { @method_test.embedded_eol("embedded\ninline") }.to raise_error(ArgumentError)
  end
end
