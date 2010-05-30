require 'rubygems'

begin
  require 'treetop'
rescue LoadError
  warn "Poison requires the Treetop gem."
  exit 1
end

task :default => :spec

parser = "lib/poison/systems/rbx/compiler/grammar.rb"
file parser => "lib/poison/systems/rbx/compiler/grammar.treetop" do |t|
  sh "tt #{t.prerequisites.first}"
end

desc "Generate the Poison parser"
task :parser => parser

desc "Build Poison"
task :build => :parser

desc "Run the Poison specs (default)"
task :spec => :build do
end
