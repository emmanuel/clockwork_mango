require 'bundler'
require File.dirname(__FILE__) + '/lib/clockwork_mango/version'

spec = Gem::Specification.new do |s|
  s.name = 'clockwork_mango'
  s.version = ClockworkMango::VERSION

  s.author = "Emmanuel Gomez"
  s.email = "emmanuel.gomez@gmail.com"
  s.homepage = "http://github.com/emmanuel/clockwork_mango"

  s.summary = 'Temporal expression toolkit in Ruby.'
  s.description = <<-DESCRIPTION
    An(other) implementation of Temporal Expressions in Ruby.
    Describe recurrence in plain english!
  DESCRIPTION

  s.files = Dir["lib/**/*.rb"]
  s.files += Dir["spec/**/*.rb"]

  s.add_bundler_dependencies
end
