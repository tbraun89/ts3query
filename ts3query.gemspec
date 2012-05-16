Gem::Specification.new do |s|
  s.name        = "ts3query"
  s.version     = "0.2.1"
  s.author      = "TnT Web Solutions"
  s.email       = "support@tnt-web-solutions.de"
  s.homepage    = "https://github.com/tntwebsolutions/ts3query"
  s.summary     = "Simple TS3 Query Library."
  s.description = "Simple TS3 Query Library to connect to the query port of a teamspeak 3 server."
  
  s.files        = Dir["{lib,features}/**/*", "[A-Z]*", "init.rb"] - ["Gemfile.lock"]
  s.require_path = "lib"
end
