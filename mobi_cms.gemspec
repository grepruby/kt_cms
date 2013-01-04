$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobi_cms/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobi_cms"
  s.version     = MobiCms::VERSION
  s.authors     = ["Priya"]
  s.email       = ["petoskey@mobizard.com"]
  s.homepage    = "https://github.com/petoskey/mobi_cms"
  s.summary     = "An engine for managing customer data types and their content"
  s.description = "An engine for managing customer data types and their content"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency "jquery-rails"
  s.add_dependency "simple_form"
  s.add_dependency 'sass-rails', '~> 3.2'
  s.add_dependency 'bootstrap-sass', '~> 2.2.2.0'
  s.add_dependency "liquid"

end
