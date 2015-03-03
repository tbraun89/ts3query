lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ts3query/version'

Gem::Specification.new do |s|
  s.name        = 'ts3query'
  s.version     = TS3Query::VERSION
  s.author      = 'TnT Web Solutions'
  s.email       = 'tbraun@tnt-web-solutions.de'
  s.homepage    = 'https://github.com/tntwebsolutions/ts3query'
  s.summary     = 'Simple TS3 Query Library.'
  s.description = 'Simple TS3 Query Library to connect to the query port of a Teamspeak 3 server.'
  s.license     = 'MIT'
  
  s.files        = Dir['{lib,features}/**/*', '[A-Z]*'] - ['Gemfile.lock']
  s.require_path = 'lib'
end
