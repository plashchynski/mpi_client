require 'rake'
require 'rubygems'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

namespace :spec do
  desc "Run remote specs"
  Spec::Rake::SpecTask.new(:remote) do |t|
    t.spec_files = FileList['remote_spec/*_spec.rb']
  end

  desc "Run all specs"
  task :all => [:spec, :remote]
end

task :default => :spec
