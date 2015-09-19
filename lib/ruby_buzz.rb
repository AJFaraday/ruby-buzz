require_relative './devinput.rb'
require_relative './button.rb'
require_relative './light.rb'
require_relative './pad.rb'

`sudo chmod 777 /sys/class/leds/*/brightness`
`sudo chmod 777 /dev/input/event*`
