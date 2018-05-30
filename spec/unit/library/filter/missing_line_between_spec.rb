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
