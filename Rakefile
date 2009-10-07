require 'rake'
require 'rubygems'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

namespace :spec do
  desc "Run remote spec"
  Spec::Rake::SpecTask.new(:remote) do |t|
    t.spec_files = FileList['remote_spec/*_spec.rb']
  end
end

task :default => :spec
