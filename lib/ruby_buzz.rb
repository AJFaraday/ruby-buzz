`sudo chmod 777 /sys/class/leds/*/brightness`
`sudo chmod 777 /dev/input/event*`

require_relative './ruby_buzz/device.rb'
require_relative './ruby_buzz/button.rb'
require_relative './ruby_buzz/light.rb'
require_relative './ruby_buzz/pad.rb'

RubyBuzz::Pad.init_mappings
