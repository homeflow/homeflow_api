# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "homeflow_api"
  s.version     = '1.0.4'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Cooper"]
  s.date        = "2013-08-06"
  s.summary     = 'The Homeflow API'
  s.description = "A gem for dealing the homeflow api"
  s.email       = "daniel@homeflow.co.uk"
  s.license     = 'MIT'

  s.add_dependency(%q<hashie>, [">= 0"])
  s.add_dependency(%q<multi_json>, [">= 0"])
  s.add_dependency(%q<httparty>, [">= 0"])
  s.add_development_dependency(%q<shoulda>, [">= 0"])
  s.add_dependency(%q<bundler>, [">= 0"])
  s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])

  s.files = `git ls-files -z`.split "\0"
  s.require_paths = ["lib"]
end
