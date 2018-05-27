# Produce end of run status about each resource.

file '/tmp/chef_resource_status' do
  action :delete
end

Chef::Config[:report_handlers] << Chef::Handler::ResourceStatus.new('/tmp/chef_resource_status')
