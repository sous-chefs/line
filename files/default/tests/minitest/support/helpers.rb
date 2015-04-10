# Helpers module
module Helpers
  # Line module (extends Helpers module)
  module Line
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
  end
end
