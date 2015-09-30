require_relative '../lib/ruby_buzz.rb'

index = ARGV[0].to_i - 1
mode = ARGV[1]

puts "index: #{index}"
puts "mode: #{mode}"

if mode == 'on'
  RubyBuzz::Light.new(index).on
else
  RubyBuzz::Light.new(index).off
end