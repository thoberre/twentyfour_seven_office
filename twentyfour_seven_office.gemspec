# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twentyfour_seven_office/version'

Gem::Specification.new do |spec|
  spec.name          = "twentyfour_seven_office"
  spec.version       = TwentyfourSevenOffice::VERSION
  spec.authors       = ["Peter Skeide"]
  spec.email         = ["ps@skalar.com"]
  spec.summary       = %q{A collection of client interfaces for various 24SevenOffice services used by Skalar}
  spec.homepage      = "https://github.com/Skalar/twentyfour_seven_office"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"

  spec.add_dependency "savon", "~> 2.3.0"
  spec.add_dependency "virtus", "~> 1.0.2"
end
