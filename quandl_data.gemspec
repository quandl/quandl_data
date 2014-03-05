# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "quandl/data/version"

Gem::Specification.new do |s|
  s.name        = "quandl_data"
  s.version     = Quandl::Data::VERSION
  s.authors     = ["Blake Hilscher"]
  s.email       = ["blake@hilscher.ca"]
  s.homepage    = "http://blake.hilscher.ca/"
  s.license     = "MIT"
  s.summary     = "For interfacing with data"
  s.description = "Data will be interfaced"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "quandl_operation", "~> 0.3"
  s.add_runtime_dependency "quandl_babelfish", "~> 0.0"
  s.add_runtime_dependency "activemodel", ">= 3.0.0"
  
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 2.13"
  s.add_development_dependency "fivemat", "~> 1.2"
  s.add_development_dependency "pry"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "quandl_utility"
end