require 'spec_helper'

# Historical Note: For those coming across this cookbook, these
# filenames were of the original author's doing (Sean O'Meara).
# There is no special meaning behind them, so don't be confused.
# He's just weird like the rest of us.

describe 'line_test::default' do
  let(:chef_run) { ChefSpec::ServerRunner.new.converge described_recipe }

  it 'creates dangerfile with HELLO as first word on a line' do
    expect(chef_run).to render_file('/tmp/dangerfile').with_content(/^HELLO.*/)
  end

  it 'creates dangerfile with line "# UNCOMMENT ME YOU FOOL"' do
    expect(chef_run).to render_file('/tmp/dangerfile')
      .with_content(/^# UNCOMMENT ME YOU FOOL$/)
  end

  it 'creates dangerfile2 with at least 1 line starting "ssh"' do
    expect(chef_run).to render_file('/tmp/dangerfile2')
      .with_content(/^ssh.*/)
  end

  it 'creates serial.conf' do
    expect(chef_run).to render_file('/tmp/serial.conf')
  end

  it 'creates listfile' do
    expect(chef_run).to render_file('/tmp/listfile')
      .with_content(/People to call:/)
  end

  it 'append if no line' do
    expect(chef_run).to edit_append_if_no_line('Operation 1')
  end

  it 'replace or add, operation 2' do
    expect(chef_run).to edit_replace_or_add('Operation 2')
  end

  it 'replace or add, operation 3' do
    expect(chef_run).to edit_replace_or_add('Operation 3')
  end

  it 'replace or add, operation 4' do
    expect(chef_run).to edit_replace_or_add('Operation 4')
  end

  it 'delete lines, operation 5' do
    expect(chef_run).to edit_delete_lines('Operation 5')
  end

  it 'delete lines, operation 6' do
    expect(chef_run).to edit_delete_lines('Operation 6')
  end

  it 'added Bobby to listfile' do
    expect(chef_run).to edit_add_to_list('Operation 7')
  end
end
