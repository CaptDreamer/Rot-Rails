$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rot_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rot_rails"
  s.version     = RotRails::VERSION
  s.authors     = ["Amit Bader"]
  s.email       = ["amit.bader@adventurebyte.com"]
  s.homepage    = "TODO"
  s.summary     = %q{Rails port of the ROT.js roguelike toolkit.}
  s.description = %q{Rails port of the ROT.js roguelike toolkit.}
  s.license     = %q{MIT}

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.0.1"

  s.add_development_dependency "sqlite3"

  s.add_development_dependency "rspec-rails"
end
