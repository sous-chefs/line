require 'rspec_helper'
include Line

describe 'between method' do
  before(:each) do
    @filt = Line::Filter.new
    @ia = %w(line1 line2 line3)
    @current = %w(line3 line2 line1 c1 c2 c1 line1 c1 c2)
    @after = %w(line3 line2 line1 c1 line2 line3 c2 c1 line1 c1 c2)
    @pattern_c1 = /c1/
    @pattern_c2 = /c2/
  end

  it 'should not insert if no lines match' do
    expect(@filt.between([], [@pattern_c1, @pattern_c2, @ia])).to eq([])
  end

  it 'should insert missing lines between first and last match of c1 and c2' do
    expect(@filt.between(@current, [@pattern_c1, @pattern_c2, @ia])).to eq(@after)
  end
end
