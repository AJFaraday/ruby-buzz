class Light

  attr_accessor :file

  def initialize(index)
    @file = `ls /sys/class/leds/*buzz#{index + 1}/brightness`
  end

  def on
    `echo 1 > #{file}`
  end

  def off
    `echo 0 > #{file}`
  end

end