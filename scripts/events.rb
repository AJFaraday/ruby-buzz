require_relative '../lib/ruby_buzz.rb'

Pad.all.each_with_index do |pad, index|
  pad.add_event :buzz,
                lambda {
                  puts "Pushed buzzer #{index}"
                  Pad.all.each{|p|p.light.off}
                  pad.light.on
                }
end

filename = ARGV[0] || "/dev/input/event10"
dev = DevInput.new filename
dev.watch

loop do
  Pad.all.each{|p|p.light.off}
  sleep 10
end