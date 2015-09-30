require_relative '../lib/ruby_hid.rb'

name = '/dev/input/by-id/usb-DragonRise_Inc._Generic_USB_Joystick-event-joystick'

dev = RubyHid::Device.new(name, 24)
dev.each do |event|
  puts event
end

