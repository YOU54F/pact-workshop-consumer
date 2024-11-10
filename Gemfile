source 'https://rubygems.org'

gem 'httparty'
gem 'rack'
gem 'rake'
gem 'sinatra'

group :development, :test do
  gem 'pact'
  gem 'pact_broker-client'
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec_junit_formatter'
  if ENV['X_PACT_DEVELOPMENT']
    gem 'sbmt-pact', path: '../../sbmt-pact'
  else
    gem 'sbmt-pact', git: 'https://github.com/YOU54F/sbmt-pact.git', branch: 'feat/pact-ruby'
  end
  gem 'combustion'
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
end
