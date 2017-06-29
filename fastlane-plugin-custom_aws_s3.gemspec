# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/custom_aws_s3/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-custom_aws_s3'
  spec.version       = Fastlane::CustomAwsS3::VERSION
  spec.author        = %q{Daniel Mendez}
  spec.email         = %q{daniel.mendez@grability.com}

  spec.summary       = %q{Upload custom file to s3 and get the signed url}
  # spec.homepage      = "https://github.com/<GITHUB_USERNAME>/fastlane-plugin-custom_aws_s3"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  spec.add_dependency 'aws-sdk', '~> 2'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 2.42.0'
end
