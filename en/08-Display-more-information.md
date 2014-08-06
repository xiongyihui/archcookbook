# Recipe 6: Display more information #

Using 4 onboard LEDs to display numbers is not convenient. So here we get a 4 7-segment display to show
numbers or time.

## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - 4 Digit Display

![Display](figures/display.png)

## Procedure ##

* Connect Grove - Digit Display to UART Grove connector
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

[!program](users/yihui/code/Arch_Digit_Display)

* Modifying the Thermistor program to use the display

Apart from display connection, connect Grove - Temperature similar to Recipe 5
The following program display temperature in deg C using display.

[!program](users/yihui/code/Arch_Display_Temperature/)

