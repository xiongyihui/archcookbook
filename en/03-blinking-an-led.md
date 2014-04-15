# Recipe 1: Blinking an LED #
A tradition of learn programming is write our first program to print a "hello, world" on our display.
In Embedded Systems, we use a blinking LED to show our first running embedded system program to the world. 

## Ingredients ##
* Seeedstudio Arch board
* Micro-USB cable
* Access to internet and online mbed compiler.

## Procedure ##
* Import the following Arch_GPIO_Ex1 program into online mbed compiler.
* Select Seeedstudio Arch as target platform (navigate to top-left corner of online compiler).
* Click Compile and Download button.
* You browser will download Arch_GPIO_Ex1_LPC11U24.bin file.
* Connect Arch board to PC using a micro-USB cable.
* Press the reset button longer(at-least 2 seconds) and release.
* You must see a USB drive being detected by you OS.
* Copy the Arch_GPIO_Ex1_LPC11U24.bin to that USB drive.
* Press and release the reset button very quickly.
* You have flashed your first program onto Arch board.

[!program](users/viswesr/code/Arch_GPIO_Ex1)

The above program uses mbed interface DigitalOut and mbed built-in function wait().
LED1 is an pseudonym given to port pin P1_8. LED1 is labelled D1 in the Arch board.
The state of LED1 is changed writing either 0 or 1 to 'led'. The mbed wait() function
produces a delay in seconds. The state of the 'led' is continuous toggled every 0.5 seconds
inside the endless *while()* loop.

The features and functions present in DigitalOut are documented in DigitalOut page in handbook.
Similarly the wait() function is documented in wait page in handbook

## Variation ##
Let us rewrite the above program using alternate APIs provided DigitalOut and wait.

[!program](users/viswesr/code/Arch_GPIO_Ex2)

Instead of led = in the Ex1 program, we have used led.write() function which essential does the same operation. 
Here, wait() is replaced by wait_us(). The delay time is specified in micro seconds instead of seconds in this function.