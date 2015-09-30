Gem::Specification.new do |s|
  s.name        = 'ruby_hid'
  s.version     = '0.0.3'
  s.date        = '2015-09-23'
  s.summary     = 'Buzz™ controller support for Ruby in Linux'
  s.description = 'Light control and button event observers for wired Buzz™ controllers in Ruby on Linux'
  s.authors     = ['Andrew Faraday']
  s.email       = 'andrewfaraday@hotmail.co.uk'
  s.files       = Dir.glob("lib/**/*") + 
                  ['lib/ruby_hid.rb'] +
                  %w{ LICENCE README.md }
  s.homepage    = 'https://github.com/AJFaraday/ruby-hid'
  s.license     = 'MIT'
  # It might work fine on 1.9
  s.required_ruby_version = '>= 2.0.0'
end
