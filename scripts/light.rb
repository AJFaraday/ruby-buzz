require_relative '../lib/ruby_hid.rb'

index = ARGV[0].to_i - 1
mode = ARGV[1]

puts "index: #{index}"
puts "mode: #{mode}"

if mode == 'on'
  RubyHid::Light.new(index).on
else
  RubyHid::Light.new(index).off
end