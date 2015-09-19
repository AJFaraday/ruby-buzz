`sudo ruby #{File.dirname(__FILE__)}/set_permissions.rb`

require_relative '../lib/ruby_buzz.rb'

data = {}

x = Thread.new do
  dev = DevInput.new
  dev.each do |event|
    puts event.code
    data[:event] = event
  end
end


loop do
  puts data.inspect
  sleep 1
end
