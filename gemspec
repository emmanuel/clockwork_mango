require 'bundler'
require 'lib/clockwork/version'

spec = Gem::Specification.new do |s|
  s.name = 'clockwork'
  s.version = Clockwork.version
  s.summary = 'Temporal expression toolkit in Ruby.'
  s.add_bundler_dependencies
end