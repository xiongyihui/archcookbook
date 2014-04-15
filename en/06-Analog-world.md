# Analog world #
## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Potentiometer

![Analog world](figures/analog_world.jpg)

## Procedure ##

* Connect middle SIG pin of Grove - Potentiometer to P0_11, other two pins to GND and 3.3V
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

The rate of blinking of the LED is controlled by the analog value read from the potentiometer.

[!program](users/viswesr/code/Arch_Analog_POT)

