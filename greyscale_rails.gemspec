$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "greyscale_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "greyscale_rails"
  s.version     = GreyscaleRails::VERSION
  s.authors     = ["Greg Orlov"]
  s.email       = ["gaorlov@gmail.com"]
  s.homepage    = "http://github.com/greyscale-io/greyscale_rails"
  s.summary     = "A collection of tools to make GReywscale development easier"
  s.description = "Rails integration with GReyscale platform tools: setup, environment management, plugins"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0"
  s.add_dependency "greyscale_record", ">= 1.0.0"
  s.add_dependency "hana"

  s.add_development_dependency "simplecov"
end
