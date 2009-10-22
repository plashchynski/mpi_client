require 'rake'
require 'rubygems'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.pattern = "spec/local/**/*_spec.rb"
end

namespace :spec do
  desc "Run remote specs"
  Spec::Rake::SpecTask.new(:remote) do |t|
    t.spec_files = FileList['spec/remote/**/*_spec.rb']
  end

  desc "Run all specs"
  task :all => [:spec, :remote]
end

task :default => :spec
