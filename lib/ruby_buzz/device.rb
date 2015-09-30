module RubyBuzz
  #
  # The main interface for the Buzz controllers. Primarily
  # used to monitor key pushes and trigger events. Keep a single
  # instance of the class:
  #
  # `RubyBuzz::Device.new`
  #
  # The `each` method exposes events directly as they come in
  #
  # `device.each { |event| puts event }`
  #
  # The `start_watching` method starts a background job which
  # runs the events bound to each button via the RubyBuzz::Button
  # class. You can end this worker with `stop_watching`.
  #
  class Device

    require 'time'

    # The worker is a thread which is watching the device
    attr_accessor :worker

    DEFAULT_FILE_NAME = "/dev/input/by-id/usb-Logitech_Logitech_Buzz_tm__Controller_V1-event-if00"

    Event = Struct.new(:tv_sec, :tv_usec, :type, :code, :value)
    # open Event class and add some convenience methods
    #
    # Holds the un-packed data parsed from the raw input from the buzz controller.
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

    #
    # Initialise device, getting event file from /dev/input/by-id/
    #
    # You can override this to a different event, but ruby-buzz only
    # supports a single usb controller.
    #
    def initialize(filename=nil)
      @dev = File.open(filename || DEFAULT_FILE_NAME)
      @block_size = 24
    rescue Errno::ENOENT => er
      puts "Could not find device: are your controllers plugged in?"
      raise er
    end

    #
    # The format for each 24 bit data chunk taken from the event stream.
    #
    def format
      'qqSSl'
    end

    #
    # Read a single 24-bit block.
    #
    def read
      bin = @dev.read @block_size
      Event.new *bin.unpack(format)
    end

    #
    # Expose each event to a block of code as it comes in.
    #
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

    #
    # Start a background worker which scans input file
    # and triggers any events bound to each one.
    #
    def start_watching
      return if @worker
      @worker = Thread.new do
        loop do
          event = read
          next unless event.type == 1
          next unless event.value == 1
          RubyBuzz::Button.trigger_key(event.code)
        end
      end
    end

    #
    # Stop the background worker, release it's resources.
    #
    def stop_watching
      @worker.kill
      @worker = nil
    end

  end
end