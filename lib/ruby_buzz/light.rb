module RubyBuzz
  class Light

    @@lights = []
    attr_accessor :file

    def initialize(index)
      @file = `ls /sys/class/leds/*buzz#{index + 1}/brightness`
      @@lights << self
    end

    def on
      `echo 1 > #{file}`
      return nil
    end

    def off
      `echo 0 > #{file}`
      return nil
    end

    def self.all_off
      @@lights.each{|l|l.off}
      return nil
    end

    def self.all_on
      @@lights.each{|l|l.on }
      return nil
    end

  end
end