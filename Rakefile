require 'rake/gempackagetask'

task :default => :spec

desc "Run the specs (default)"
task :spec => :build do
  sh "mspec spec"
end

C        = RbConfig::CONFIG
CC       = ENV['CC'] || C['CC']
CFLAGS   = ENV['CFLAGS'] || C['CFLAGS']
LDSHARED = ENV['LDSHARED'] || C['LDSHARED']
LDFLAGS  = ENV['LDFLAGS'] || C['LDFLAGS']
dlext    = C['DLEXT']

parser_d = File.expand_path "../lib/poison/bootstrap/parser/ext", __FILE__
parser_g = parser_d + "/parser.g"
parser_c = parser_d + "/parser.c"
parser_o = parser_d + "/parser.o"
parser_e = parser_d + "/parser.#{dlext}"

greg     = File.expand_path "../tools/greg", __FILE__

file parser_c => [greg, parser_g] do |t|
  sh "tools/greg #{t.prerequisites.last} > #{t.name}"
end

file parser_o => parser_c do |t|
  sh "#{CC} -o #{t.name} -I#{C['rubyhdrdir']} #{CFLAGS} -c #{t.prerequisites.first}"
end

file parser_e => parser_o do |t|
  sh "#{LDSHARED} -o #{t.name} #{LDFLAGS} #{t.prerequisites.first}"
end

desc "Generate the parser source"
task :parser => parser_c

desc "Build the parser extension"
task :build => [:parser, parser_e]

desc "Clean the parser extension files"
task :clean do
  rm_f Dir[parser_d + "/{parser.c,*.o,*.#{dlext}}"]
end

desc "Build greg parser generator"
file greg do
  sh "#{CC} -O3 -DNDEBUG -o tools/greg tools/greg.c tools/compile.c tools/tree.c -Itools"
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
  s.add_dependency 'mspec', '~> 1.5.0'
end

Rake::GemPackageTask.new(spec){ |pkg| pkg.gem_spec = spec }
