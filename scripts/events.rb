require_relative '../lib/ruby_hid.rb'

RubyHid::Pad.all.each_with_index do |pad, index|
  pad.add_event :buzz,
                lambda {
                  puts "Pushed buzzer #{index}"
                  Pad.all.each{|p|p.light.off}
                  pad.light.on
                }
end

dev = RubyHid::Device.new
dev.start_watching

begin
  loop do
    RubyHid::Light.all.each{|p|p.light.off}
    sleep 10
  end 
rescue SystemExit, Interrupt
  RubyHid::Light.all_off
end
