ruby-buzz
==========

A Ruby library for controlling the LEDs on buzz controllers in Linux.

* Linux only
* Wired buzz controllers only

Example Scripts
===============

The scripts folder contains examples of the input and output
functionality for the buzz controllers.

Turn on buzzer 1

`ruby scripts/light.rb 1 on`

-------------

Turn off buzzer 1

`ruby scripts/light.rb 1 off`

-------------

Watch the inputs

`ruby scripts/read.rb`

(press ctrl+c to stop)

-------------

Pushing the buzzer lights that buzzer 

`ruby scripts/events.rb`

(press ctrl+c to stop)


Using it in your code
=====================

Lights
------

Include the ruby_buzz library

`require 'ruby_buzz'`

The Buzz controller has 4 pads, each of which has four lights.
They can be accessed like so:

```ruby
# Via the pads
RubyBuzz::Pad[0]
RubyBuzz::Pad[0].light
RubyBuzz::Pad.all
# A control for light 1, divorced from the pad.
RubyBuzz::Light.new(0)
```

Control one light:

```ruby
pad = RubyBuzz::Pad[0]
pad.light.on
sleep 1
pad.light.off
```

A quick light show

```ruby
RubyBuzz::Pad.all.each do |pad|
  pad.light.on
  sleep 0.1
end 
RubyBuzz::Pad.all.each do |pad|
  pad.light.off
  sleep 0.1
end 
```

If you abandon your script before all the lights are turned off they
will say on indefinitely. You may want to rescue SystemExit and Interrupt
errors with `RubyBuzz::Light.all_off` E.g.

```ruby
begin
  loop do
    RubyBuzz::Pad[rand(4)].light.on
    RubyBuzz::Pad[rand(4)].light.off
    sleep 0.1
  end 
rescue SystemExit, Interrupt
  RubyBuzz::Light.all_off
end
```

Button events
-------------

Include the ruby_buzz library

`require 'ruby_buzz'`


Acknowledgements
===============

This repo includes a modified version of the devinput class from
https://github.com/kamaradclimber/libdevinput
Which was forked from
https://github.com/prullmann/libdevinput