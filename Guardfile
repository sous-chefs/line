# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', spec_paths: [ 'spec' ] do
  watch(%r{^spec/.+spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
  watch(%r{recipes/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{([A-Za-z]+)/(.+)(\..*)?$}) { |m| "spec/*.rb" }
end

