ruby-hid
==========

A Ruby library for controlling the LEDs on buzz controllers in Linux.

* Linux only
* Wired buzz controllers only

*Warning:* ruby_hid has to change some rights down in the /sys and /dev
folders of Linux in order to access the kernel. You will be asked for
your password in order to use ruby_hid.

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

Button events
-------------

Include the ruby_hid library

`require 'ruby_hid'`

The Buzz controller has 4 pads, each of which has four buttons named:
 
 * buzz
 * blue
 * orange
 * green
 * yellow

They can be found like this:

```ruby
RubyHid::Pad[0]
RubyHid::Pad[0].buttons
RubyHid::Pad[0].buttons[:buzz]
RubyHid::Pad.all
```

You can define a block of code to be run by a given button like this:

```ruby
RubyHid::Pad[0].add_event(
  :buzz,
  lambda {
    puts "Player 1 buzzed!"
  }
)
```

You can debug the actions you've added to a button with trigger_events

```ruby
RubyHid::Pad[0].trigger_events
```

How about getting it to run when you press the button?

The RubyHid::Device class is responsible for reading the raw input
from the Buzz controllers via the linux terminal. Because it's reading
a data stream, it needs to start a background process to allow it to 
work while other ruby code is operating.

You can start background process, which executes the events you added
to the buttons, with start_watching.

```ruby
device = RubyHid::Device.new
RubyHid::Pad.all.each do |pad|
  pad.add_event(:buzz, lambda { puts "Buzz!" }
)
device.start_watching
```

Note: This process will end when your ruby process ends, but if you
want to stop it before that stage, you can call `device.stop_watching`

If you want to do nothing other than watch the buttons, you may want
to follow start_watching with an empty loop.

```ruby
device = RubyHid::Device.new
RubyHid::Pad.all.each do |pad|
  pad.add_event(:buzz, lambda { puts "Buzz!" }
)
device.start_watching

loop do

end 
```

Acknowledgements
===============

This repo includes a modified version of the devinput class from
https://github.com/kamaradclimber/libdevinput
Which was forked from
https://github.com/prullmann/libdevinput