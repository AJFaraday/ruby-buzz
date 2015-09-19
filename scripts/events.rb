require_relative '../lib/ruby_buzz.rb'

Pad.all.each_with_index do |pad, index|
  pad.add_event :buzz,
                lambda {
                  puts "Pushed buzzer #{index}"
                  Pad.all.each{|p|p.light.off}
                  pad.light.on
                }
end

dev = DevInput.new
dev.start_watching

begin
  loop do
    Pad.all.each{|p|p.light.off}
    sleep 10
  end 
rescue SystemExit, Interrupt
  Pad.all.each{|p|p.light.off}
end
