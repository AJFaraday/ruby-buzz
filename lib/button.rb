class Button

  @@buttons = []

  # events will be an array of lambdas
  attr_accessor :name, :code, :events

  def initialize(code, name, pad)
    @code = code
    @name = name
    @pad = pad
    @events = []
    @@buttons << self
  end

  def Button.find(code)
    @@buttons.detect { |b| b.code == code }
  end

  def add_event(proc)
    @events << proc
  end

  def trigger_events
    @events.each do |event|
      event.call
    end
  end

  def Button.trigger_key(code)
    btn = Button.find(code)
    btn.trigger_events
  end

end