# Recipe 3: Digital Input #

## Ingredients ##

In addition to things listed in Recipe 1 we require

* Grove - Button

![Digital Input](figures/digital_input.png)

## Procedure

* connect Grove - Button to on-board grove connector marked UART.
* Import the following Arch_GPIO_Ex3 program into online mbed compiler.
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

This program keeps the LED1 on as long as the button is pressed.

[!program](users/viswesr/code/Arch_GPIO_Ex3)

We use DigitalIn interface to read the status of a tactile switch connected to port pin P1_14.
The button.read() function returns a value 1 if button is pressed and 0 if released. 
This value is written to LED1 port pin using led.write().

More information on this new module is available at DigitalIn handbook page.