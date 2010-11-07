require 'rake/gempackagetask'

begin
  require 'treetop'
rescue LoadError
  warn "Poison requires the Treetop gem."
  exit 1
end

task :default => :spec

parser = "lib/poison/bootstrap/compiler/grammar.rb"
file parser => "lib/poison/bootstrap/compiler/grammar.treetop" do |t|
  sh "tt #{t.prerequisites.first}"
end

desc "Generate the Poison parser"
task :parser => parser

desc "Build Poison"
task :build => :parser

desc "Run the Poison specs (default)"
task :spec => :build do
  sh "mspec spec"
end

spec = Gem::Specification.new do |s|
  require File.expand_path('../lib/poison/version', __FILE__)

  s.name                      = "poison"
  s.version                   = Poison::VERSION.to_s

  s.specification_version     = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = ["Brian Ford"]
  s.date                      = %q{2010-11-06}
  s.email                     = %q{brixen@gmail.com}
  s.has_rdoc                  = true
  s.extra_rdoc_files          = %w[ README LICENSE ]
  s.executables               = ["poison"]
  s.files                     = FileList[ '{bin,lib,spec}/**/*.{yaml,txt,rb}', 'Rakefile', *s.extra_rdoc_files ]
  s.homepage                  = %q{http://github.com/brixen/poison}
  s.require_paths             = ["lib"]
  s.rubygems_version          = %q{1.3.5}
  s.summary                   = "Poison is an interpretation of Potion on the Rubinius VM."
  s.description               = <<EOS
Poison is a programming language based on Potion by Why The Lucky Stiff
that runs on the Rubinius VM.
EOS

  s.rdoc_options << '--title' << 'Poison Gem' <<
                    '--main' << 'README' <<
                    '--line-numbers'
end

Rake::GemPackageTask.new(spec){ |pkg| pkg.gem_spec = spec }
