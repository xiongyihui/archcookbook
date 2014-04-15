# Arch platform #

Seeedstudio Arch is a mbed enabled platform based on NXP's LPC11U24 microcontroller. 
This platforms comes with header pins whose footprint are compatible with Arduino shields.
 The two on-board Grove connectors can be interfaced with numerous Grove based sensors, actuators and display modules.

Arch platform can be easily programmed over USB using the LPC11U24's inbuilt ISP driver. 
Unlike mbed LPC11U24, Arch platform does not come with mbed interface chip. Hence, 
an additional Arch board has to be used to debug the target using CMSIS-DAP.


## Features ##

* Shields compatible header pins
* Two Grove connectors
* A large number of grove modules
* Drag-n-drop programming
* NXP LPC11U24 MCU
* Low power ARM Cortex-M0 Core
* 48MHz, 32KB Flash, 8KB RAM, 4KB EEPROM
* USB Device, 2xSPI, UART, I2C

## Hardware ##

![Arch V1.1 Pinout](figures/arch_v1.1_pinout.png)

### Digital In/Out ###
All pins with light blue coloured lable can be used as DigitalOut/DigitalIn/DigitalInOut interface.


### PwmOut ###
Pins labelled as PwmOut (i.e magenta colourd lable) are possible outputs that can be routed from timers to generate PWM.

### UART ###
The TXD or RXD labelled pins (i.e yellow coloured label) are possible routing pins for one UART port.
At a time, one TXD and one RXD pin can be configured for the UART.