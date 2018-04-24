# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "homeflow/api/version"

Gem::Specification.new do |s|
  s.name        = "homeflow_api"
  s.version     = Homeflow::Api::Version::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Cooper"]
  s.date        = "2013-08-06"
  s.summary     = 'The Homeflow API'
  s.description = "A gem for dealing the homeflow api"
  s.email       = "daniel@homeflow.co.uk"
  s.license     = 'MIT'

  s.add_dependency 'hashie' ,    '3.4.3'     # Version after 3.4.3 have very poor performance MJE
  s.add_dependency 'multi_json', '1.12.2'
  s.add_dependency 'httparty'
  s.add_dependency 'bundler'

  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'jeweler', '~> 1.6.4'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency "rspec"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
