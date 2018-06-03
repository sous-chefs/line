require 'rspec_helper'
include Line

describe 'replace method' do
  before(:each) do
    @filt = Line::Filter.new
    @ia = %w(line1 line2 line3)
    @current = %w(line3 line2 line1 c1 line3 line2 c1 line1 c1 c2)
    @solo_start = %w(c1 linef lineg lineh )
    @solo_middle = %w(linef c1 lineg )
    @solo_end = %w(linef lineg lineh c1)
    @allthere = %w(line3 line2 line1 line1 line2 line3 line3 line2 line1 line2 line3 line1 line1 line2 line3 c2)
    @allthere_c2 = %w(line3 line2 line1 line1 line2 line3 line3 line2 line1 line2 line3 line1 line1 line2 line3 line1 line2 line3)
    @pattern_c1 = /c1/
    @pattern_c1_c2 = /c1|c2/
  end

  it 'should not replace if no lines match' do
    expect(@filt.replace([], [@pattern_c1, @ia])).to eq([])
  end

  it 'should replace each match of c1' do
    expect(@filt.replace(@current, [@pattern_c1, @ia])).to eq(@allthere)
  end

  it 'should replace each match of c1 and c2' do
    expect(@filt.replace(@current, [@pattern_c1_c2, @ia])).to eq(@allthere_c2)
  end

  it 'should replace the first line' do
    expect(@filt.replace(@solo_start, [@pattern_c1, @ia])).to eq(%w(line1 line2 line3 linef lineg lineh))
  end

  it 'should replace the middle line' do
    expect(@filt.replace(@solo_middle, [@pattern_c1, @ia])).to eq(%w(linef line1 line2 line3 lineg))
  end

  it 'should replace the end line' do
    expect(@filt.replace(@solo_end, [@pattern_c1, @ia])).to eq(%w(linef lineg lineh line1 line2 line3))
  end

  it 'should raise error if the pattern matchs the replacement lines' do
    expect { @filt.replace(@current, [@pattern_c1, ['c1 match', 'c2']]) }.to raise_error(ArgumentError)
  end

  it 'should not raise error if the pattern matchs the replacement lines, force the change' do
    expect { @filt.replace(@current, [@pattern_c1, ['c1 match', 'c2'], true]) }.to_not raise_error(ArgumentError)
  end
end
