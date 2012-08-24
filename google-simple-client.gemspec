# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google-simple-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anders Janmyr"]
  gem.email         = ["anders@janmyr.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google-simple-client"
  gem.require_paths = ["lib"]
  gem.version       = Google::Simple::Client::VERSION
end
