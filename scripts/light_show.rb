require_relative '../lib/ruby_hid.rb'

begin
  loop do
    RubyHid::Pad[rand(4)].light.on
    RubyHid::Pad[rand(4)].light.off
    sleep 0.1
  end
rescue SystemExit, Interrupt
  RubyHid::Light.all_off
end
