require_relative '../lib/ruby_buzz.rb'

RubyBuzz::Pad.all.each_with_index do |pad, index|
  pad.add_event :buzz,
                lambda {
                  puts "Pushed buzzer #{index}"
                  Pad.all.each{|p|p.light.off}
                  pad.light.on
                }
end

dev = RubyBuzz::Device.new
dev.start_watching

begin
  loop do
    RubyBuzz::Light.all.each{|p|p.light.off}
    sleep 10
  end 
rescue SystemExit, Interrupt
  RubyBuzz::Light.all_off
end
