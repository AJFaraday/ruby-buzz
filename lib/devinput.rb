#!/usr/bin/env ruby

class DevInput

  require 'time'

  # The worker is a thread which is watching the device
  attr_accessor :worker

  KEY_VALUES = ['Release', 'Press', 'Repeat']

  Event = Struct.new(:tv_sec, :tv_usec, :type, :code, :value)
  # open Event class and add some convenience methods
  class Event
    def time;
      Time.at(tv_sec)
    end

    def to_s
      type_s = type.to_s
      code_s = code.to_s
      value_s = value.to_s
      "#{time.iso8601} type: #{type_s} code: #{code_s} value: #{value_s}"
    end
  end

  def initialize(filename)
    @dev = File.open(filename)
    @block_size = 24
  end

  def format
    'qqSSl'
  end


  def read
    bin = @dev.read @block_size
    Event.new *bin.unpack(format)
  end

  def each
    begin
      loop do
        event = read
        next unless event.type == 1
        next unless event.value == 1
        yield event
      end
    rescue Errno::ENODEV
    end
  end


  def watch
    @worker = Thread.new do
      begin
        loop do
          event = read
          next unless event.type == 1
          next unless event.value == 1
          Button.trigger_key(event.code)
        end
      rescue Errno::ENODEV
      end
    end
  end

  def stop_watching
    @worker.kill
  end

end



