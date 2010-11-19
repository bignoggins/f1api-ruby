# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{f1api}
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jesse Dearing"]
  s.date = %q{2010-11-19}
  s.description = %q{Consumes the Fellowship One API in your apps using ActiveResource.  Implements 2nd party credentials-based authenticaion and full OAuth implementation. }
  s.email = %q{jdearing@fellowshiptech.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "VERSION.yml",
    "config/f1-oauth.yml",
    "f1api.gemspec",
    "lib/f1api.rb",
    "lib/f1api/activeresource/base.rb",
    "lib/f1api/activeresource/connection.rb",
    "lib/f1api/client.rb",
    "lib/f1api/configuration.rb",
    "lib/f1api/oauth.rb",
    "lib/f1api/oauth/credentials_authentication.rb",
    "lib/f1api/oauth/oauth_authentication.rb",
    "test/fixtures/access_token.rb",
    "test/fixtures/http.rb",
    "test/fixtures/request_token.rb",
    "test/unit/configuration_test.rb",
    "test/unit/credentials_test.rb",
    "test/unit/oauth_test.rb"
  ]
  s.homepage = %q{http://github.com/jessedearing/f1api}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Consume the Fellowship One API in your apps using ActiveResource}
  s.test_files = [
    "test/fixtures/access_token.rb",
    "test/fixtures/http.rb",
    "test/fixtures/request_token.rb",
    "test/unit/configuration_test.rb",
    "test/unit/credentials_test.rb",
    "test/unit/oauth_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<oauth>, ["= 0.4.4"])
      s.add_runtime_dependency(%q<mocha>, [">= 0"])
      s.add_runtime_dependency(%q<activeresource>, [">= 0"])
      s.add_runtime_dependency(%q<oauth>, ["= 0.4.4"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_runtime_dependency(%q<activeresource>, [">= 0"])
    else
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<oauth>, ["= 0.4.4"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<activeresource>, [">= 0"])
      s.add_dependency(%q<oauth>, ["= 0.4.4"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<activeresource>, [">= 0"])
    end
  else
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<oauth>, ["= 0.4.4"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<activeresource>, [">= 0"])
    s.add_dependency(%q<oauth>, ["= 0.4.4"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<activeresource>, [">= 0"])
  end
end

