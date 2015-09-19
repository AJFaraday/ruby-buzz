`sudo ruby #{File.dirname(__FILE__)}/set_permissions.rb`

require_relative '../lib/devinput.rb'

$data = {}

x = Thread.new do
  filename = ARGV[0] || "/dev/input/event10"
  puts "opening #{filename}"
  dev = DevInput.new filename
  dev.each do |event|
    puts event.code
    $data[:event] = event
  end
end


loop do
  puts $data.inspect
  sleep 1
end
