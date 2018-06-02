require 'rspec_helper'
include Line

describe 'stanza method' do
  before(:each) do
    @filt = Line::Filter.new
    @ia = %w(line1 line2 line3)
    @current = [
      '[head1]',
      '# comment',
      '  key1 = val1',
      '# comment',
      '  key2 = val1',
      '[head2]',
      '  key2 = val2',
      '  key3 = val3',
      '[head3]',
      '  key3.1 = val1',
      '[head4]',
    ]
  end

  it 'should add stanza to an empty array' do
    expect(@filt.stanza([], ['newstanza', { key1: 'value1', key2: 'value2' }])).to eq(
      [
        '[newstanza]',
        '  key1 = value1',
        '  key2 = value2',
      ]
    )
  end

  it 'should add stanza to an existing array' do
    out_array = @current.dup
    ip = out_array.size
    out_array[ip] = '[newstanza]'
    out_array[ip + 1] = '  key1 = value1'
    out_array[ip + 2] = '  key2 = value2'
    expect(@filt.stanza(@current.dup, ['newstanza', { key1: 'value1', key2: 'value2' }])).to eq(out_array)
  end

  it 'should replace values in a stanza' do
    out_array = @current.dup
    out_array[2] = '  key1 = replace1'
    expect(@filt.stanza(@current.dup, ['head1', { key1: 'replace1' }])).to eq(out_array)
  end

  it 'should replace multiple values in a stanza' do
    out_array = @current.dup
    out_array[6] = '  key2 = replace2'
    out_array[7] = '  key3 = replace3'
    expect(@filt.stanza(@current.dup, ['head2', { key2: 'replace2', key3: 'replace3' }])).to eq(out_array)
  end

  it 'should replace and add values in a stanza' do
    out_array = @current.dup
    out_array[9] = '  newkey = insertvalue'
    out_array[10] = '  key3.1 = replace1'
    out_array[11] = '[head4]'
    expect(@filt.stanza(@current.dup, ['head3', { 'key3.1' => 'replace1', newkey: 'insertvalue' }])).to eq(out_array)
  end

end
