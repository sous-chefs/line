# FIXME: re-enable these? Fix paths.

# require 'spec_helper'

# # Historical Note: For those coming across this cookbook, these
# # filenames were of the original author's doing (Sean O'Meara).
# # There is no special meaning behind them, so don't be confused.
# # He's just weird like the rest of us.

# describe 'line::tester' do
#   let(:chef_run) { ChefSpec::SoloRunner.new.converge 'line::tester' }

#   it 'creates dangerfile with HELLO as first word on a line' do
#     expect(chef_run).to render_file('/tmp/dangerfile').with_content(/^HELLO.*/)
#   end

#   it 'creates dangerfile with line "# UNCOMMENT ME YOU FOOL"' do
#     expect(chef_run).to render_file('/tmp/dangerfile').with_content(/^# UNCOMMENT ME YOU FOOL$/)
#   end

#   it 'creates dangerfile2 with at least 1 line starting "ssh"' do
#     expect(chef_run).to render_file('/tmp/dangerfile2').with_content(/^ssh.*/)
#   end

#   it 'creates dangerfile3 with at least 1 line starting "my"' do
#     expect(chef_run).to render_file('/tmp/dangerfile3').with_content(/^my.*/)
#   end

#   it 'creates serial.conf' do
#     expect(chef_run).to render_file('/tmp/serial.conf')
#   end
# end
