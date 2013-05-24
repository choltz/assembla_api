lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'assembla_api/version'

Gem::Specification.new do |gem|
  gem.name          = "assembla_api"
  gem.version       = AssemblaApi::VERSION
  gem.authors       = ["choltz"]
  gem.email         = ["choltz@gmail.com"]
  gem.description   = %q{Ruby wrapper for the Assembla API}
  gem.summary       = %q{Ruby wrapper for the Assembla API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec",    "~> 2.12.0"
  gem.add_development_dependency "debugger", "~> 1.4.0"

  gem.add_dependency "typhoeus", "~> 0.6.1"
end
