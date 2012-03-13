# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "neology/version"

Gem::Specification.new do |s|
  s.name        = "neology"
  s.version     = Neology::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Carlo Alberto Degli Atti"
  s.email       = "lordkada@gmail.com"
  s.homepage    = "http://github.com/lordkada/neology"
  s.summary     = "Ruby client library to Neo4jRest API"
  s.description = "Porting the neo4j (API) to the REST world"


  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.0.0"
  s.add_dependency 'neography', '~> 0.0.22'
end