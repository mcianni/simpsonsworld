# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simpsons_world/version'

Gem::Specification.new do |spec|
  spec.name          = "simpsons_world"
  spec.version       = SimpsonsWorld::VERSION
  spec.authors       = ["mcianni"]
  spec.email         = ["mcianni@gmail.com"]
  spec.summary       = %q{Link to episodes on SimpsonsWorld}
  spec.description   = %q{Link to seasons and episodes on the comprehensive Simpsons World website.}
  spec.homepage      = "https://github.com/mcianni/simpsonsworld"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

end
