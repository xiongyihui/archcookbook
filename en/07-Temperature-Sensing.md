# Recipe 5: Temperature Sensing #
## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Temperature Sensor

![Temperature Sensing](figures/temperature.png)

## Procedure ##

* Connect SIG pin of Grove - Temperature Sensor to P0_11, other two pins to GND and 3.3V
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

The room temperature is displayed as LED blinks. LED4 blinks corresponding to tens place of temperature value(in deg C) and LED1 blinks according to units place.

[!program](users/viswesr/code/Arch_Analog_Thermistor_Blinker)

