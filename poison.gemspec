# -*- encoding: utf-8 -*-
require File.expand_path('../lib/poison/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "poison"
  gem.version       = "#{Poison::VERSION}"
  gem.authors       = ["Brian Shirai"]
  gem.email         = ["brixen@gmail.com"]
  gem.homepage      = "https://github.com/brixen/poison"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) unless File.extname(f) == ".bat" }.compact
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
  gem.summary       = "Poison is an interpretation of Potion on the Rubinius VM."
  gem.description   = <<EOS
Poison is a programming language based on Potion by Why The Lucky Stiff
that runs on the Rubinius VM.
EOS

  gem.has_rdoc          = true
  gem.extra_rdoc_files  = %w[ README.md LICENSE ]
  gem.rubygems_version  = %q{1.3.5}

  gem.rdoc_options  << '--title' << 'Poison Gem' <<
                    '--main' << 'README' <<
                    '--line-numbers'

  gem.add_runtime_dependency     'redcard', '~> 1.0'
  gem.add_development_dependency 'mspec', '~> 1.5.0'
end
