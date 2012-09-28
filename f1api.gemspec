# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{f1api}
  s.version = "0.10.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jesse Dearing"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.description = %q{Consumes the Fellowship One API in your apps using ActiveResource.  Implements 2nd party credentials-based authenticaion and full OAuth implementation. }
  s.email = %q{jesse.dearing@activenetwork.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = `git ls-files`.split($\)

  s.test_files = %w[
    test/fixtures/access_token.rb
    test/fixtures/http.rb
    test/fixtures/request_token.rb
    test/unit/configuration_test.rb
    test/unit/credentials_test.rb
    test/unit/oauth_test.rb
  ]
  s.homepage = "http://github.com/fellowshiptech/f1api-ruby"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.summary = %q{Consume the Fellowship One API in your apps using ActiveResource}

  s.add_dependency('oauth', ">= 0.4.4")
  s.add_dependency('activeresource')
  s.add_development_dependency('mocha')
end

