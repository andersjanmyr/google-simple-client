# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google-simple-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Anders Janmyr']
  gem.email         = ['anders@janmyr.com']
  gem.description   = %q{Simplifies the usage of google-api-client and
                         provides a command line tool for finding and
                         getting documents from Google Drive.}
  gem.summary       = %q{Simplifies the usage of google-api-client.}
  gem.homepage      = "https://github.com/andersjanmyr/google-simple-client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'google-simple-client'
  gem.require_paths = ['lib']
  gem.version       = GoogleSimpleClient::VERSION
  gem.add_dependency 'mechanize'
  gem.add_dependency 'google-api-client'

  gem.add_development_dependency 'rspec'
end
