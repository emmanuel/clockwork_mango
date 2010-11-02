require 'bundler'
require File.dirname(__FILE__) + '/lib/clockwork_mango/version'

spec = Gem::Specification.new do |s|
  s.name = 'clockwork_mango'
  s.version = ClockworkMango.version
  s.summary = 'Temporal expression toolkit in Ruby.'
  s.add_bundler_dependencies
end
