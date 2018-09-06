$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "api_safe_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "api_safe_auth"
  s.version     = ApiSafeAuth::VERSION
  s.authors     = [""]
  s.email       = ["shredder-rull@yandex.ru"]
  s.homepage    = "http://github.com/shredder-rull/api_safe_auth"
  s.summary     = "Safe authorization for API"
  s.description = "Safe authorization for API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"  
end
