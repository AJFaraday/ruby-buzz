`sudo chmod 777 /sys/class/leds/*/brightness`
`sudo chmod 777 /dev/input/event*`

require_relative './ruby_hid/device.rb'
require_relative './ruby_hid/input.rb'
require_relative './ruby_hid/light.rb'
