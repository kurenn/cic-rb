# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#$: << 'lib'

require 'cic/version'

Gem::Specification.new do |gem|
  gem.name          = "cic"
  gem.version       = Cic::VERSION
  gem.authors       = ["Abraham Kuri Vargas"]
  gem.email         = ["kurenn@icalialabs.com"]
  gem.description   = %q{Communicates the CIC API}
  gem.summary       = %q{CIC Api Integration}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.name          = 'cic'
  gem.version       = Cic::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.rubyforge_project = 'cic'
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "httparty"
  gem.add_dependency "hashie"
  gem.add_dependency "activesupport"
  gem.add_dependency "json"
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'shoulda-matchers'
  gem.test_files  = Dir.glob("{spec}/**/*.rb")
end
