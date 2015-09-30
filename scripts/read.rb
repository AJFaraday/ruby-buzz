require_relative '../lib/ruby_buzz.rb'

Thread.new do
  dev = RubyBuzz::Device.new
  dev.each do |event|
    puts event
  end
end

# loop just keeps the ruby script alive
loop do
  sleep 1
end
