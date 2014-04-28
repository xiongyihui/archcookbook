# Recipe 1: Blinking an LED #
When we get started with programming, a traditional first program is a "Hello world" program 
to output "Hello, world" on a display. While a display is not always available in embedded systems,
blinking an LED is substituted for "Hello world" as our first embedded system program. Let's make
an LED blink.

## Ingredients ##
* Seeedstudio Arch board
* Micro-USB cable
* Access to internet and mbed online compiler.

## Procedure ##
* Import the following Arch_GPIO_Ex1 program into online mbed compiler.
* Select Seeedstudio Arch as target platform (navigate to top-left corner of online compiler).
* Click Compile and Download button.
* You browser will download Arch_GPIO_Ex1_LPC11U24.bin file.
* Connect Arch board to PC using a micro-USB cable.
* Press the reset button longer(at-least 2 seconds) and release.
* You must see a USB drive being detected by you OS.
* Delete the firmware.bin in that USB drive, then copy the Arch_GPIO_Ex1_LPC11U24.bin to that USB drive.
* Press and release the reset button very quickly.
* You have flashed your first program onto Arch board.

[!program](users/viswesr/code/Arch_GPIO_Ex1)

The above program uses the [DigitalOut][] interface and mbed built-in function [wait()](http://mbed.org/handbook/Wait).
**LED1** is an pseudonym given to port pin **P1_8**. LED1 is labelled **D1** in the Arch board.
The state of LED1 is changed writing either 0 or 1 to **led**. The **wait()** function
produces a delay in seconds. The state of the **led** is continuous toggled every 0.5 seconds
inside the endless **while()** loop.

## Variation ##
Let us rewrite the above program using alternate APIs provided DigitalOut and wait.

[!program](users/viswesr/code/Arch_GPIO_Ex2)

Instead of **led =** in the Ex1 program, we have used **led.write()** function which essential does the same operation. 
Here, **wait()** is replaced by **wait_us()**. The delay time is specified in micro seconds instead of seconds in this function.