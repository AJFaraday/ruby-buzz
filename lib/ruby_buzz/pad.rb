# Each of these is an individual players controller
module RubyBuzz
  class Pad

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

    def self.init_mappings
      @@pads = []
      MAPPINGS.each_with_index do |mapping, index|
        @@pads << new(mapping, index)
      end
    end

    def self.all
      @@pads
    end

    def self.[](index)
      @@pads[index]
    end

    def initialize(mapping, index)
      @index = index
      @buttons = {}
      @light = RubyBuzz::Light.new(index)
      mapping.each do |code, name|
        @buttons[name] = RubyBuzz::Button.new(code, name, self)
      end
    end

    def add_event(button_name, proc)
      @buttons[button_name].add_event proc
    end

    def trigger_event(button_name)
      @buttons[button_name].trigger_events
    end

  end
end