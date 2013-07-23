# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "homeflow_api"
  s.version = "0.17.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Cooper"]
  s.date = "2013-07-23"
  s.description = "A gem for dealing the homeflow api"
  s.email = "daniel@homeflow.co.uk"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "homeflow_api.gemspec",
    "lib/homeflow/api.rb",
    "lib/homeflow/api/agency.rb",
    "lib/homeflow/api/branch.rb",
    "lib/homeflow/api/collection.rb",
    "lib/homeflow/api/county.rb",
    "lib/homeflow/api/delete.rb",
    "lib/homeflow/api/exceptions.rb",
    "lib/homeflow/api/favourite_property.rb",
    "lib/homeflow/api/lead.rb",
    "lib/homeflow/api/location.rb",
    "lib/homeflow/api/message.rb",
    "lib/homeflow/api/password_reset.rb",
    "lib/homeflow/api/place.rb",
    "lib/homeflow/api/portal.rb",
    "lib/homeflow/api/post.rb",
    "lib/homeflow/api/postcode.rb",
    "lib/homeflow/api/property.rb",
    "lib/homeflow/api/put.rb",
    "lib/homeflow/api/query.rb",
    "lib/homeflow/api/queryable.rb",
    "lib/homeflow/api/request.rb",
    "lib/homeflow/api/request_specification.rb",
    "lib/homeflow/api/resource.rb",
    "lib/homeflow/api/resource_identifier.rb",
    "lib/homeflow/api/response.rb",
    "lib/homeflow/api/search.rb",
    "lib/homeflow/api/session.rb",
    "lib/homeflow/api/site.rb",
    "lib/homeflow/api/site_content_chunk.rb",
    "lib/homeflow/api/site_page.rb",
    "lib/homeflow/api/user.rb",
    "spec/data/example_search_response.json",
    "spec/data/invalid_api_key.json",
    "spec/data/property_details.json",
    "spec/data/with_alt_places.json",
    "spec/homeflow_api_spec.rb",
    "spec/query_spec.rb",
    "spec/response_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/homeflow/Homeflow_Api"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Homeflow API Gem"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
    else
      s.add_dependency(%q<hashie>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    end
  else
    s.add_dependency(%q<hashie>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
  end
end

