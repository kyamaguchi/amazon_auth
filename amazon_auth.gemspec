# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'amazon_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "amazon_auth"
  spec.version       = AmazonAuth::VERSION
  spec.authors       = ["Kazuho Yamaguchi"]
  spec.email         = ["kzh.yap@gmail.com"]

  spec.summary       = %q{Login amazon.}
  spec.description   = %q{Login amazon.}
  spec.homepage      = "https://github.com/kyamaguchi/amazon_auth"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'capybara'
  spec.add_runtime_dependency 'selenium-webdriver'
  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'dotenv'
  spec.add_runtime_dependency 'activesupport'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"
end
