require 'spec_helper'

describe 'line::tester' do
  let(:chef_run) { ChefSpec::Runner.new.converge 'line::tester' }

  it 'creates dangerfile' do
    expect(chef_run).to create_cookbook_file('/tmp/dangerfile').with_owner('root').with_mode('00644')
  end
  
end

