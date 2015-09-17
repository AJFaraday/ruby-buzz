# TODO rewrite this as a ruby lib
index = ARGV[0].to_i
mode = ARGV[1] == 'on' ? '1' : '0'

puts "index: #{index}"
puts "mode: #{mode}"

`sudo ruby #{File.dirname(__FILE__)}/set_permissions.rb`

file = `ls /sys/class/leds/*buzz#{index}/brightness`

`echo #{mode} > #{file}`
