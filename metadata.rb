name 'line'
maintainer 'Sean OMeara'
maintainer_email 'someara@chef.io'
license 'Apache2'
description 'Provides line editing resources for use by recipes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'
source_url 'https://github.com/someara/line-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/someara/line-cookbook/issues' if respond_to?(:issues_url)
chef_version      '>= 12.5' if respond_to?(:chef_version)

%w( debian ubuntu centos redhat scientific oracle amazon ).each do |os|
  supports os
end
