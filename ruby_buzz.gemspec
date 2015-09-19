Gem::Specification.new do |s|
  s.name        = 'ruby_buzz'
  s.version     = '0.0.1'
  s.date        = '2015-09-19'
  s.summary     = 'Buzz™ controller support for Ruby in Linux'
  s.description = 'Light control and button event observers for wireed Buzz™ controllers in Ruby on Linux'
  s.authors     = ['Andrew Faraday']
  s.email       = 'andrewfaraday@hotmail.co.uk'
  s.files       = Dir.glob("lib/**/*") + 
                  ['lib/ruby_buzz.rb'] + 
                  %w{ LICENCE README.md }
  s.homepage    = 'https://github.com/AJFaraday/ruby-buzz'
  s.license     = 'MIT'
end
