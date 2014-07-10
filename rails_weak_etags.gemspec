$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_weak_etags/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_weak_etags"
  s.version     = RailsWeakEtags::VERSION
  s.authors     = ["John Naegle"]
  s.email       = ["john.naegle@gmail.com"]
  s.homepage    = "http://github.com/john.naegle/rails_weak_etags"
  s.summary     = "Converts strong e-tags to weak."
  s.description = "Converts strong e-tags to weak so they can be passed through nginx with g-zip compression enabled"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.1"

  s.add_development_dependency "sqlite3"
end
