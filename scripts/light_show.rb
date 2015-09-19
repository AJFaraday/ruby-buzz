require_relative '../lib/ruby_buzz.rb'

begin
  loop do
    RubyBuzz::Pad[rand(4)].light.on
    RubyBuzz::Pad[rand(4)].light.off
    sleep 0.1
  end
rescue SystemExit, Interrupt
  RubyBuzz::Light.all_off
end
