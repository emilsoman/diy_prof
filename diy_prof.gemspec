# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diy_prof/version'

Gem::Specification.new do |spec|
  spec.name          = "diy_prof"
  spec.version       = DiyProf::VERSION
  spec.authors       = ["Emil Soman"]
  spec.email         = ["emil.soman@gmail.com"]

  spec.summary       = %q{Quick and dirty call graph visualiser}
  spec.description   = %q{Capture (a part of) ruby code call graph in a PDF for easier understanding. Dependency: GraphViz}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
