require File.expand_path("../lib/instapaper", __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'instapaper'
  gem.version = Instapaper::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "A very simple Instapaper library and commandline client"

  gem.authors  = ['Jordan Elver']
  gem.email    = 'jordan.elver@gmail.com'
  gem.homepage = 'http://github.com/jordelver/instapaper'

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  gem.executables = ['instapaper']
end