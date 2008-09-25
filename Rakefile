#!/usr/bin/env ruby
require 'pathname'
require 'rubygems'
require 'rake'
require 'hoe'
require 'spec/rake/spectask'

require 'lib/clockwork'

ROOT = Pathname(__FILE__).dirname.expand_path

Hoe.new('clockwork', Clockwork::VERSION::STRING) do |p|
  p.developer('Emmanuel Gomez', 'emmanuel.gomez@gmail.com')
end

task :spec do
  all_specs = ROOT + 'spec/**/*_spec.rb'
  
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_opts << '--colour' << '--loadby' << 'random'
    t.spec_files = Pathname.glob(ENV['FILES'] || all_specs)
    # t.rcov = rcov
    # t.rcov_opts << '--exclude' << 'spec,environment.rb'
    # t.rcov_opts << '--text-summary'
    # t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
    # t.rcov_opts << '--only-uncovered'
  end
end
