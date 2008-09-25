require 'pathname'
require 'rubygems'
gem 'rspec', '>=1.1.3'
require 'spec'

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path
require SPEC_ROOT.parent + 'lib/clockwork'
