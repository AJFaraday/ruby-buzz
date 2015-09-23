module RubyBuzz
  # Each of these is an individual players controller
  #
  # Each USB device has four of these.
  #
  # Each pad has 5 buttons:
  #
  # * buzz
  # * yellow
  # * green
  # * orange
  # * blue
  #
  # Accessed by `pad.buttons[:buzz]` etc
  #
  # Each pad has a single LED light under the buzz button.
  #
  # Accessed by `pad.light`
  #
  # Accessing Pad objects:
  #
  # * `Pad.all`
  # * `Pad[0]` etc.
  #
  # Defining an event on a button
  #
  # `pad.add_event(:buzz, lambda{ puts 'Buzz pushed!' })`
  #
  # Triggering a button event (for debugging)
  #
  # `pad.trigger_events(:buzz)`
  #
  class Pad

    # Event code mappings for each button. Split into pads.
    # {event_code => button_name}
    MAPPINGS = [
      {
        704 => :buzz,
        705 => :yellow,
        706 => :green,
        707 => :orange,
        708 => :blue
      },
      {
        709 => :buzz,
        710 => :yellow,
        711 => :green,
        712 => :orange,
        713 => :blue
      },
      {
        714 => :buzz,
        715 => :yellow,
        716 => :green,
        717 => :orange,
        718 => :blue
      },
      {
        719 => :buzz,
        720 => :yellow,
        721 => :green,
        722 => :orange,
        723 => :blue
      }
    ]

    attr_accessor :buttons, :light

    # called by lib/ruby_buzz.rb
    #
    # Reads the MAPPINGS constant and creates the 4 pad objects.
    #
    def self.init_mappings
      @@pads = []
      MAPPINGS.each_with_index do |mapping, index|
        @@pads << new(mapping, index)
      end
    end

    #
    # Returns all four pads in index order.
    #
    def self.all
      @@pads
    end

    #
    # Call a specific pad by index (0 to 3)
    #
    def self.[](index)
      @@pads[index]
    end

    #
    # Initialize pad objects, called by init_mappings
    #
    # Arguments:
    #
    # * mapping - hash of event codes against button name (from MAPPINGS)
    # * index - index of this pad, from 0 to 3
    #
    def initialize(mapping, index)
      @index = index
      @buttons = {}
      @light = RubyBuzz::Light.new(index)
      mapping.each do |code, name|
        @buttons[name] = RubyBuzz::Button.new(code, name, self)
      end
    end

    #
    # Add an event mapping, to be triggered on button push.
    #
    # Arguments:
    #
    # * button_name - Symbol, name of the button to be pushed
    # * proc - Proc, a ruby method to be called.
    #
    # As the Proc is run on a separate thread, with the same environment,
    # it is wise to change data in a shared space (for instance, a class
    # variable or a setter method) for the main body of your code to
    # respond to instead of doing the heavy lifting in the button event.
    #
    def add_event(button_name, proc)
      @buttons[button_name].add_event proc
    end

    #
    # For debugging: Trigger a button event directly.
    # Also called by watcher in RubyBuzz::Device.
    #
    # Arguments:
    #
    # * button_name - Symbol name of buzzer (:buzz, :yellow, :green, :orange, :blue)
    #
    def trigger_event(button_name)
      @buttons[button_name].trigger_events
    end

  end
end