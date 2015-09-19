require_relative '../lib/ruby_buzz.rb'

Pad.all.each_with_index do |pad, index|
  pad.add_event :buzz, lambda { puts "Pushed buzzer #{index}" }
end

filename = ARGV[0] || "/dev/input/event10"
dev = DevInput.new filename
dev.watch

n = 0
loop do
  n += 1
  puts n
  sleep 1
end