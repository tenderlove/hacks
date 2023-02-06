# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "hacks"
  s.version     = "0.0.2"
  s.summary     = "Ruby C internals exposed as Ruby"
  s.description = "These are some hacks I use. This gem exposes some Ruby C internals as Ruby functions and constants"
  s.authors     = ["Aaron Patterson"]
  s.email       = "tenderlove@ruby-lang.org"
  s.files       = `git ls-files -z`.split("\x0")
  s.test_files  = s.files.grep(%r{^test/})
  s.homepage    = "https://github.com/tenderlove/hacks"
  s.license     = "Apache-2.0"
  s.require_paths = ["lib"]
  s.extensions = ["ext/hacks/extconf.rb"]

  s.add_development_dependency("rake", "~> 13.0")
  s.add_development_dependency("minitest", "~> 5.14")
end
