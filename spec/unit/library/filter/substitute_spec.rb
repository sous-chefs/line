require 'rspec_helper'
include Line

describe 'substitute method' do
  before(:each) do
    @filt = Line::Filter.new
    @current = ['line3', 'line2 Stuff', 'line1', 'c1', 'line3', 'line2 funny', '# c1', 'line1', 'c1', 'c2']
    @solo_start = %w(c1 linef lineg lineh )
    @solo_middle = %w(linef c1 lineg )
    @solo_end = %w(linef lineg lineh c1)
    @pattern_c1 = /c1/
    @new_str = 'Replacement'
    @err_str = 'c1 plus'
    @pattern_c1_c2 = /c1|c2/
  end

  it 'should not change if no lines match' do
    expect(@filt.substitute([], [@pattern_c1])).to eq([])
  end

  it 'should substitute each match of c1' do
    out_lines = @current.dup
    out_lines[3] = 'Replacement'
    out_lines[6] = '# Replacement'
    out_lines[8] = 'Replacement'
    expect(@filt.substitute(@current, [@pattern_c1, @new_str])).to eq(out_lines)
  end

  it 'should substitute each match of c1 and c2' do
    out_lines = @current.dup
    out_lines[3] = 'Replacement'
    out_lines[6] = '# Replacement'
    out_lines[8] = 'Replacement'
    out_lines[9] = 'Replacement'
    expect(@filt.substitute(@current, [@pattern_c1_c2, @new_str])).to eq(out_lines)
  end

  it 'should substitute the first line' do
    out_lines = @solo_start
    out_lines[0] = 'Replacement'
    expect(@filt.substitute(@solo_start, [@pattern_c1, @new_str])).to eq(out_lines)
  end

  it 'should substitute the middle line' do
    out_lines = @solo_middle
    out_lines[1] = 'Replacement'
    expect(@filt.substitute(@solo_middle, [@pattern_c1, @new_str])).to eq(out_lines)
  end

  it 'should substitute the end line' do
    out_lines = @solo_end
    out_lines[3] = 'Replacement'
    expect(@filt.substitute(@solo_end, [@pattern_c1, @new_str])).to eq(out_lines)
  end

  it 'should match a line and use the substitute pattern' do
    out_lines = @current
    out_lines[1] = 'line2 nonsense'
    expect(@filt.substitute(@current, [/^line2/, 'nonsense', /stuff/i])).to eq(out_lines)
  end
 
  it 'should match all lines and use the substitute pattern' do
    out_lines = @current
    out_lines[5] = 'line2 serious'
    expect(@filt.substitute(@current, [/^/, 'serious', /funny/i])).to eq(out_lines)
  end
 
  it 'should error in case of continuing changes' do
    out_lines = @current
    out_lines[9] = 'c2 plus'
    expect{@filt.substitute(@current, [/c2/, 'c2 plus'])}.to raise_error(ArgumentError)
  end
 
  it 'should allow force in case of continuing changes' do
    out_lines = @current
    out_lines[9] = 'c2 plus'
    expect(@filt.substitute(@current, [/c2/, 'c2 plus',nil ,true])).to eq(out_lines)
  end

end
