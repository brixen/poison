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
  rm_f FileList["**/*.rbc"]
end

desc "Build greg parser generator"
file greg do
  sh "#{CC} -O3 -DNDEBUG -o tools/greg tools/greg.c tools/compile.c tools/tree.c -Itools"
end
