# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "anniversary/version"

Gem::Specification.new do |s|
  s.name        = "anniversary"
  s.version     = Anniversary::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rick Denatale"]
  s.email       = ["rick.denatale@gmail.com", "rickd@scimedsolutions.com"]
  s.homepage    = ""
  s.summary     = %q{Add method to Ruby's Date to get [years, months, days] between two dates}
  s.description = %q{Adds the method Date#years_months_days_since which returns the number of days, months and years since another date}

  s.rubyforge_project = "anniversary"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.add_development_dependency "rspec", "~>2"
  s.require_paths = ["lib"]
end
