ruby-buzz
==========

A Ruby library for controlling the LEDs on buzz controllers in Linux

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


Acknowledgements
===============

This repo includes a modified version of the devinput class from
https://github.com/kamaradclimber/libdevinput
Which was forked from
https://github.com/prullmann/libdevinput