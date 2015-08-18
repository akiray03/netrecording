# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'netrecording/version'

Gem::Specification.new do |spec|
  spec.name          = "netrecording"
  spec.version       = Netrecording::VERSION
  spec.authors       = ["Akira Yumiyama"]
  spec.email         = ["yumiyama.akira@gmail.com"]

  spec.summary       = %q{Records network requests and responses for easy stubbing of external calls.}
  spec.description   = %q{Records network requests and responses for easy stubbing of external calls.}
  spec.homepage      = "https://github.com/akiray03/netrecording"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "fakeweb"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
