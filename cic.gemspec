# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#$: << 'lib'

require 'cic/version'

Gem::Specification.new do |gem|
  gem.name          = "cic"
  gem.version       = Cic::VERSION
  gem.authors       = ["Abraham Kuri Vargas", "Alicia Catalina"]
  gem.email         = ["kurenn@icalialabs.com", "alicia@icalialabs.com"]
  gem.description   = %q{Communicates the CIC API}
  gem.summary       = %q{CIC Api Integration}
  gem.homepage      = "https://github.com/IcaliaLabs/cic-rb"
  gem.licenses      = ["MIT"]

  gem.files         = `git ls-files`.split($/)
  gem.name          = 'cic'
  gem.version       = Cic::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.rubyforge_project = 'cic'
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "httparty", '~> 0.13.3'
  gem.add_dependency "hashie", '~> 3'
  gem.add_dependency "activesupport", '~> 4.2'
  gem.add_dependency "json", '~> 1.8.1'
  gem.add_development_dependency 'rspec', '~> 3.1.0'
  gem.add_development_dependency 'pry-byebug', '~> 2.0.0'
  gem.add_development_dependency 'shoulda-matchers', '~> 2.7.0'
  gem.test_files  = Dir.glob("{spec}/**/*.rb")
end
