format    = ENV.fetch("GUARD_RSPEC_FORMAT", "--format progress")
fail_fast = ENV.fetch("GUARD_RSPEC_FAIL_FAST", "--fail-fast")
drb       = ENV["GUARD_RSPEC_DRB"] ? "--drb" : ""

guard 'rspec', :cli => "--color #{format} #{fail_fast} #{drb}" do
  watch('spec/spec_helper.rb')                       { "spec" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
end
