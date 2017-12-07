# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_sales'
  s.version     = '3.3.0'
  s.summary     = 'Add sales prices to products'
  s.description = 'Add sales prices to products'
  s.required_ruby_version = '>= 2.2.7'

  s.author    = 'Vincent K Edison'
  s.email     = 'vincent@luxodev.com'
  s.homepage  = 'https://www.luxodev.com'
  s.license   = 'MIT'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.3.0'
  s.add_dependency 'spree_frontend', '~> 3.3.0'
  s.add_dependency 'date_validator'
  s.add_dependency 'spree_extension'

  s.add_development_dependency 'capybara', '~> 2.7'
  s.add_development_dependency 'coffee-rails', '~> 4.2'
  s.add_development_dependency 'database_cleaner', '~> 1.5'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.5'
  s.add_development_dependency 'sass-rails', '~> 5.0.0.beta1'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
