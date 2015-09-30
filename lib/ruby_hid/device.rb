module RubyHid
  #
  # The main interface for the Buzz controllers. Primarily
  # used to monitor key pushes and trigger events. Keep a single
  # instance of the class:
  #
  # `RubyHid::Device.new`
  #
  # The `each` method exposes events directly as they come in
  #
  # `device.each { |event| puts event }`
  #
  # The `start_watching` method starts a background job which
  # runs the events bound to each button via the RubyHid::Button
  # class. You can end this worker with `stop_watching`.
  #
  class Device

    #
    # Event types we're interested in, used to filter out meta-data.
    #
    # 1 - button type
    #
    ALLOWED_EVENT_TYPES = [
      1
    ]

    #
    # List possible devices from /dev/input/by-id/
    #
    # Or, list devices containing a string with search_term argument
    #
    def Device.list(search_term=nil)
      if search_term
        Dir["/dev/input/by-id/*#{search_term}*event*"]
      else
        Dir['/dev/input/by-id/*event*']
      end
    end

    require 'time'

    # The worker is a thread which is watching the device
    attr_accessor :worker

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
    def initialize(filename=nil, block_size=16)
      @dev = File.open(filename)
      @block_size = block_size
    rescue Errno::ENOENT => er
      puts "Could not find device: are your controllers plugged in?"
      raise er
    end

    #
    # The format string which RubyHid uses to decode raw data.
    #
    def format
      @format ||= case @block_size
                    when 16
                      'llSSl'
                    when 24
                      'qqSSl'
                  end
    end

    #
    # Read a single block.
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
          if event
            next unless ALLOWED_EVENT_TYPES.include?(event.type)
            yield event
          end
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
          next unless ALLOWED_EVENT_TYPES.include?(event.type)
          RubyHid::Button.trigger_key(event.code)
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