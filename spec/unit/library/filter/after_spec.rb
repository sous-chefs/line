require 'rspec_helper'
include Line

describe 'after method' do
  before(:each) do
    @filt = Line::Filter.new
    @ia = %w(line1 line2 line3)
    @current = %w(line3 line2 line1 c1 line3 line2 c1 line1 c1 c2)
    @solo_start = %w(c1 linef lineg lineh )
    @solo_middle = %w(linef c1 lineg )
    @solo_end = %w(linef lineg lineh c1)
    @allthere = %w(line3 line2 line1 c1 line1 line3 line2 c1 line2 line3 line1 c1 line1 line2 line3 c2)
    @allthere_c2 = %w(line3 line2 line1 c1 line1 line3 line2 c1 line2 line3 line1 c1 line1 line2 line3 c2 line1 line2 line3)
    @first_match_c1 = %w(line3 line2 line1 c1 line3 line2 c1 line1 c1 c2)
    @last_match_c1_c2 = %w(line3 line2 line1 c1 line3 line2 c1 line1 c1 c2 line1 line2 line3 )
    @pattern_c1 = /c1/
    @pattern_c1_c2 = /c1|c2/
  end

  it 'should not insert if no lines match' do
    expect(@filt.after([], [@pattern_c1, @ia, :each])).to eq([])
  end

  it 'should not insert if no lines match - first' do
    expect(@filt.after([], [@pattern_c1, @ia, :first])).to eq([])
  end

  it 'should not insert if no lines match - last' do
    expect(@filt.after([], [@pattern_c1, @ia, :last])).to eq([])
  end

  it 'should insert missing lines after each match of c1' do
    expect(@filt.after(@current, [@pattern_c1, @ia, :each])).to eq(@allthere)
  end

  it 'should insert missing lines after each match of c1 and c2' do
    expect(@filt.after(@current, [@pattern_c1_c2, @ia, :each])).to eq(@allthere_c2)
  end

  it 'should insert missing lines after the first match of c1 and c2' do
    expect(@filt.after(@current, [@pattern_c1_c2, @ia, :first])).to eq(@first_match_c1)
  end

  it 'should insert missing lines after the last match of c1 and c2' do
    expect(@filt.after(@current, [@pattern_c1_c2, @ia, :last])).to eq(@last_match_c1_c2)
  end

  it 'should insert after match of the first line - each' do
    expect(@filt.after(@solo_start, [@pattern_c1, @ia, :each])).to eq(%w(c1 line1 line2 line3 linef lineg lineh))
  end

  it 'should insert after match of the first line - first' do
    expect(@filt.after(@solo_start, [@pattern_c1, @ia, :first])).to eq(%w(c1 line1 line2 line3 linef lineg lineh))
  end

  it 'should insert after match of the first line - last' do
    expect(@filt.after(@solo_start, [@pattern_c1, @ia, :last])).to eq(%w(c1 line1 line2 line3 linef lineg lineh))
  end

  it 'should insert after match of the last line - each' do
    expect(@filt.after(@solo_end, [@pattern_c1, @ia, :each])).to eq(%w(linef lineg lineh c1 line1 line2 line3 ))
  end

  it 'should insert after match of the last line - first' do
    expect(@filt.after(@solo_end, [@pattern_c1, @ia, :first])).to eq(%w(linef lineg lineh c1 line1 line2 line3 ))
  end

  it 'should insert after match of the last line - last' do
    expect(@filt.after(@solo_end, [@pattern_c1, @ia, :last])).to eq(%w(linef lineg lineh c1 line1 line2 line3 ))
  end

  it 'should insert after match of a middle line - each' do
    expect(@filt.after(@solo_middle, [@pattern_c1, @ia, :each])).to eq(%w(linef c1 line1 line2 line3 lineg))
  end

  it 'should insert after match of a middle line - first' do
    expect(@filt.after(@solo_middle, [@pattern_c1, @ia, :first])).to eq(%w(linef c1 line1 line2 line3 lineg))
  end

  it 'should insert after match of a middle line - last' do
    expect(@filt.after(@solo_middle, [@pattern_c1, @ia, :last])).to eq(%w(linef c1 line1 line2 line3 lineg))
  end
end
