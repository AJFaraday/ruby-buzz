ruby-buzz
==========

A Ruby library for controlling the LEDs on buzz controllers in Linux

Scripts
=======

Once your buzzers are plugged in ensure you have permission
(will open some linux /sys and /dev files' rights)

`sudo ruby scripts/set_permissions.rb`

Turn on buzzer 1

`ruby scripts/light.rb 1 on`

Turn off buzzer 1

`ruby scripts/light.rb 1 off`

acknowledgements
===============

This repo includes a modified version of the devinput class from
https://github.com/kamaradclimber/libdevinput
