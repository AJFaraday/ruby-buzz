module RubyHid
  #
  # Each Pad has one LED light under the buzzer button.
  #
  # There are four Light objects, each controls one of these lights.
  #
  # Accessed via Pad:
  #
  # `RubyHid::Pad[0].light`
  #
  # Controlled individually:
  #
  # * `RubyHid::Pad[0].light.on`
  # * `RubyHid::Pad[0].light.off`
  #
  # Controlled together:
  #
  # * RubyHid::Light.all_on
  # * RubyHid::Light.all_off
  #
  class Light

    @@lights = []
    attr_accessor :file

    #
    # Initialize a buzzer by index 0 to 3.
    #
    # Arguments:
    #
    # * index - Integer, 0 to 3, which light does this represent.
    #
    def initialize(index)
      @file = `ls /sys/class/leds/*buzz#{index + 1}/brightness`
      @@lights << self
    end

    #
    # Turn the light on
    #
    def on
      `echo 1 > #{file}`
      return nil
    end

    #
    # Turn the light off
    #
    def off
      `echo 0 > #{file}`
      return nil
    end

    #
    # Turn all lights off
    #
    def self.all_off
      @@lights.each{|l|l.off}
      return nil
    end

    #
    # Turn all lights on
    #
    def self.all_on
      @@lights.each{|l|l.on }
      return nil
    end

  end
end