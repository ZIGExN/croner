$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "croner/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "croner"
  s.version     = Croner::VERSION
  s.authors     = ["ykogure"]
  s.email       = ["renkin1008@gmail.com"]
  s.homepage    = "https://github.com/ZIGExN/croner"
  s.summary     = "TODO: Summary of Croner."
  s.description = "TODO: Description of Croner."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "mysql2"
end
