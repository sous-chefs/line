# frozen_string_literal: true

require 'chefspec'
require 'fileutils'
require 'tmpdir'

Dir.glob('libraries/*.rb').each do |lib|
  require_relative "../#{lib}"
end

chefspec_cookbook_path = Dir.mktmpdir('line-chefspec-cookbooks')
FileUtils.ln_s(File.expand_path('..', __dir__), File.join(chefspec_cookbook_path, 'line'))
FileUtils.ln_s(
  File.expand_path('fixtures/cookbooks/spectest', __dir__),
  File.join(chefspec_cookbook_path, 'spectest')
)

RSpec.configure do |config|
  config.cookbook_path = chefspec_cookbook_path
  config.after(:suite) { FileUtils.rm_rf(chefspec_cookbook_path) }
  config.expose_dsl_globally = true
  config.mock_with :rspec do |mocks|
    mocks.allow_message_expectations_on_nil = true
  end
end
