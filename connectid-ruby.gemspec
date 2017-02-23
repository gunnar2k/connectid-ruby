Gem::Specification.new do |s|
  s.name        = 'connectid-ruby'
  s.version     = '0.0.1'
  s.date        = '2017-02-23'
  s.summary     = "ConnectID API"
  s.description = "A simple library for connecting to ConnectID API"
  s.authors     = ["Gunnar Fornes"]
  s.email       = 'gunnarfornes@gmail.com'
  s.files       = ["lib/connectid-ruby.rb"]
  s.homepage    =
    'http://rubygems.org/gems/connect-id.rb'
  s.license       = 'MIT'

  s.add_dependency "activesupport"
  s.add_dependency "oauth2"
end
