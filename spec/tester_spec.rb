require 'spec_helper'

describe 'line::tester' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'line::tester' }

  it 'creates dangerfile' do
    expect(chef_run).to create_cookbook_file '/tmp/dangerfile'
    file = chef_run.cookbook_file '/tmp/dangerfile'
    expect(file).to be_owned_by('root')
    expect(file.mode).to eq("00644")
  end
  
end

