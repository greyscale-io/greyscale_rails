$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "greyscale_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "greyscale_rails"
  s.version     = GreyscaleRails::VERSION
  s.authors     = ["Greg Orlov"]
  s.email       = ["gaorlov@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of GreyscaleRails."
  s.description = "TODO: Description of GreyscaleRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_development_dependency "sqlite3"
end
