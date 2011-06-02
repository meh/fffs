#! /usr/bin/env ruby
require 'rake'

task :default => :test

task :test do
  Dir.chdir 'test'

  sh 'rspec filesystem_spec.rb --color --format doc'
end
