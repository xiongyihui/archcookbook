# Preface #

"Anyone can cook." - Gusteau's (a character in Ratatouille)

This cookbook is a starting point to work with Seeedstudio Arch platform. 
It introduces the platform with step by step examples by using Seeedstudio 
Grove modules. The cookbook is written with beginners in mind and assumes 
no prior experience in mbed API. This book expects a basic knowledge of C 
programming language. mbed API and programs are written C++ language. 
Although not essential to understand the programs, it is better you 
understand how to create an object for a class and how to use member functions.

If you are beginner, who is learning Embedded Systems and programming in 
C/C++ - import andexecute the examples programs one by one by following the 
procedure listed in each recipe. You can skip all other fine details presented 
in the beginning.

Happy Programming :)



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

**Arch_GPIO_Ex1** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_GPIO_Ex1)

~~~~{.cpp}
#include "mbed.h"

/* Configure a GPIO pin as output for controlling a LED. 'led' is user assigned name and
 'LED1' is a internal name given to a port pin P1_8 in this Arch platform. */
DigitalOut led(LED1);

int main()
{
    while(1) {
        led = 1;    // Switch ON the LED.
        wait(0.5);  // Wait for 0.5 Seconds.
        led = 0;    // Switch OFF the LED.
        wait(0.5);  // Wait for 0.5 Seconds.
    }
}

~~~~

The above program uses the [DigitalOut][] interface and mbed built-in function [wait()](http://mbed.org/handbook/Wait).
**LED1** is an pseudonym given to port pin **P1_8**. LED1 is labelled **D1** in the Arch board.
The state of LED1 is changed writing either 0 or 1 to **led**. The **wait()** function
produces a delay in seconds. The state of the **led** is continuous toggled every 0.5 seconds
inside the endless **while()** loop.

## Variation ##
Let us rewrite the above program using alternate APIs provided DigitalOut and wait.

**Arch_GPIO_Ex2** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_GPIO_Ex2)

~~~~{.cpp}
#include "mbed.h"

/* Configure a GPIO pin as output for controlling a LED. 'led' is an user assigned name and
 'LED1' is an internal name given to a port pin P1_8 in this Arch platform. */
DigitalOut led(LED1);

int main()
{
    while(1) {
        led.write(1);    // Here, DigitalOut -> write() function is used to set the ouput high.
        wait_ms(500);    // Wait for 0.5 Seconds. The time is specified in milli-seconds using wait_ms() function.
        led.write(0);    // Switch OFF the LED.
        wait_us(500000); // Wait for 0.5 Seconds. The time is specified in micro-seconds using wait_us() function.
    }
}

~~~~

Instead of **led =** in the Ex1 program, we have used **led.write()** function which essential does the same operation. 
Here, **wait()** is replaced by **wait_us()**. The delay time is specified in micro seconds instead of seconds in this function.

# Recipe 2: Controlling multi LEDs #

The following program uses one variable to modify a set of 4 LEDs with BusOut interface. 
The LED1 to LED4 counts up 4-bit binary value one by one with half-a-second delay. 
BusOut interface comes handy while sending data to devices with parallel ports like LCDs.

## Ingredients ##
* Same as Recipe 1.

## Procedure

* Import, build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

**Arch_GPIO_Ex4** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_GPIO_Ex4)

~~~~{.cpp}
#include "mbed.h"

BusOut onboardLEDs(P1_8,P1_9,P1_10,P1_11); /*P1_8 - P1_11 are LED1 - LED4*/

int main()
{
    int i;
    while(1) {
        for(i=0; i<16; i++) {
            onboardLEDs.write(i); /* LED1 is LSB  and LED4 is MSB*/
            wait(0.5);
        }

    }
}

~~~~



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

**Arch_GPIO_Ex3** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_GPIO_Ex3)

~~~~{.cpp}
#include "mbed.h"

DigitalOut led(LED1);    // Configure LED1 pin as output
DigitalIn button(P1_14); // Configure P1_14 pin as input

int main()
{
    while(1) {
        led.write(button.read());    /* read the state of input port pin P1_14 and write it to output port pin LED1*/
    }
}

~~~~

We use DigitalIn interface to read the status of a tactile switch connected to port pin P1_14.
The button.read() function returns a value 1 if button is pressed and 0 if released. 
This value is written to LED1 port pin using led.write().

More information on this new module is available at DigitalIn handbook page.

# Recipe 4: Analog world #



## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Potentiometer

![Analog world](figures/analog_world.png)

## Procedure ##

* Connect Grove - Potentiometer to the Grove connector named "Analog"
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

The rate of blinking of the LED is controlled by the analog value read from the potentiometer.

**Arch_Analog_POT** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_Analog_POT)

~~~~{.cpp}
#include "mbed.h"

AnalogIn pot(P0_11);   /* Potentiometer middle pin connected to P0_11, other two ends connected to GND and 3.3V */
DigitalOut led(LED1);  /* LED blinks with a delay based on the analog input read */

int main()
{
    float ain;   /* Variable to store the analog input*/

    while(1) {
        ain = pot.read(); /* Read analog value (output will be any value between 0 and 1 */
        led = 1;          /* Switch ON LED        */
        wait(ain);        /* Wait for 'ain' Seconds (maximum delay is 1 seconds)*/
        led = 0;          /* Switch Off LED       */
        wait(ain);        /* Wait for 'ain' Seconds (maximum delay is 1 seconds)*/
    }
}

~~~~



# Recipe 5: Temperature Sensing #
## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Temperature Sensor

![Temperature Sensing](figures/temperature.png)

## Procedure ##

* Connect SIG pin of Grove - Temperature Sensor to P0_11, other two pins to GND and 3.3V
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

The room temperature is displayed as LED blinks. LED4 blinks corresponding to tens place of temperature value(in deg C) and LED1 blinks according to units place.

**Arch_Analog_Thermistor_Blinker** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/viswesr/code/Arch_Analog_Thermistor_Blinker)

~~~~{.cpp}
#include "mbed.h"

AnalogIn thermistor(P0_11);   /* Thermistor output connected to P0_11 */

DigitalOut tensplaceLED(LED4);  /* This led blinks as per tens place of temperature value(in deg C) */
DigitalOut unitsplaceLED(LED1); /* This led blinks as per units place of temperature value(in deg C) */

int main()
{
    unsigned int a, beta = 3975, units, tens;
    float temperature, resistance;

    while(1) {
        a = thermistor.read_u16(); /* Read analog value */
        
        /* Calculate the resistance of the thermistor from analog votage read. */
        resistance= (float) 10000.0 * ((65536.0 / a) - 1.0);
        
        /* Convert the resistance to temperature using Steinhart's Hart equation */
        temperature=(1/((log(resistance/5000.0)/beta) + (1.0/298.15)))-273.15; 
        
        units = (int) temperature % 10;
        tens  = (int) temperature / 10;
        
        
        for(int i=0; i< tens; i++)
        {
             tensplaceLED = 1;
             wait(.200);
             tensplaceLED = 0;
             wait(.200);
        }
        
        for(int i=0; i< units; i++)
        {
             unitsplaceLED = 1;
             wait(.200);
             unitsplaceLED = 0;
             wait(.200);
        }
      
        wait(0.5);
    }
}


~~~~



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

**Arch_Digit_Display** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_Digit_Display)

~~~~{.cpp}
#include "mbed.h"
#include "DigitDisplay.h"

DigitDisplay display(P1_14, P1_13); // 4-Digit Display connected to UART Grove connector
DigitalOut   led(LED1);

int main() {
    int count = 0;
    while(1) {
        display = count;
        count++;
        led = !led;
        wait(1);
    }
}

~~~~

* Modifying the Thermistor program to use the display

Apart from display connection, connect Grove - Temperature similar to Recipe 5
The following program display temperature in deg C using display.

**Arch_Display_Temperature** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_Display_Temperature/)

~~~~{.cpp}
#include "mbed.h"
#include "DigitDisplay.h"

DigitDisplay display(P1_14, P1_13); // 4-Digit Display connected to UART Grove connector
AnalogIn thermistor(P0_12);         // Thermistor output connected to P0_12

int main() {
    unsigned int a;
    unsigned int beta = 3975;
    float temperature, resistance;
 
    while(1) {
        a = thermistor.read_u16(); /* Read analog value */
        
        /* Calculate the resistance of the thermistor from analog votage read. */
        resistance= (float) 10000.0 * ((65536.0 / a) - 1.0);
        
        /* Convert the resistance to temperature using Steinhart's Hart equation */
        temperature = (1/((log(resistance/10000.0)/beta) + (1.0/298.15)))-273.15; 
        
        display = (int)temperature;
      
        wait(0.5);
    }
}

~~~~



# Recipe 7: Be colorful #

Instead of display a temperature in deg C, using a color to map a temperature is more beautiful.

## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Temperature
* Grove - Chainable RGB LED


## Procedure ##

* Connect Grove - Temperature to the Grove connector named "Analog"
* Connect Grove - Chainable RGB LED to the Grove connector named "UART"
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

**be_colorful** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/be_colorful)

~~~~{.cpp}
#include "mbed.h"
#include "ChainableLED.h"

//#define DEBUG

#ifdef DEBUG

#include "USBSerial.h"
#define LOG(args...)        pc.printf(args)
USBSerial pc;

#else

#define LOG(args...)

#endif  // DEBUG


// ChainableLED(clk, data, number_of_leds)
ChainableLED color_led(P1_14, P1_13, 1);
AnalogIn thermistor(P0_12);

float get_temperature()
{
    unsigned int a, beta = 3975;
    float temperature, resistance;
    
    a = thermistor.read_u16();
    
    /* Calculate the resistance of the thermistor from analog votage read. */
    resistance = (float) 10000.0 * ((65536.0 / a) - 1);
    
    /* Convert the resistance to temperature using Steinhart's Hart equation */
    temperature=(1/((log(resistance/10000.0)/beta) + (1.0/298.15)))-273.15; 
    
    return temperature;
}

int temperature2color(float t)
{
    float low  = 26;
    float high = 30;
    int   min = 0;
    int   max = 255;
    int   color;
    
    if (t < low) {
        color = min;
    } else if (t > high) {
        color = max;
    } else {
        color = min + (max - min) * ((t - min) / (max - min));
    }
    
    return color;
}
    

int main() {
  
    while(1) {
        float t = get_temperature();
        uint8_t color = temperature2color(t);
        
        LOG("Temperature: %f\r\n", t);
        LOG("Color: %d\r\n", color);
        
        // ChainableLED.setColorRGB(index_of_led, red, green, blue)
        color_led.setColorRGB(0, color, 0xFF - color, 0);
        wait(0.05);
    }
}


~~~~



# Recipe 8: A little sound #

## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - Buzz

## Procedure ##

* Connect Grove - Buzz to the Grove connector named "UART"
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

**Arch_Play_Music** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_Play_Music)

~~~~{.cpp}
#include "mbed.h"
#include "pitches.h"

DigitalOut myled(LED1);

PwmOut buzzer(P1_14);

int frequency[] = {NOTE_C4, NOTE_G3,NOTE_G3, NOTE_A3, NOTE_G3, 1, NOTE_B3, NOTE_C4};
int beat[] = {4, 8, 8, 4,4,4,4,4 };

int main() {
    for (int i = 0; i < (sizeof(frequency) / sizeof(int)); i++) {
        buzzer.period(1.0 / frequency[i]);
        buzzer.write(0.5);
        wait(1.0 / beat[i]);
        buzzer.write(0);
        wait(0.05);
    }
    
    while(1) {
        myled = !myled;
        wait(1);
    }
}

~~~~


# Recipe 9: Capacitive Touch #

Capacitive touch key is widely used these days. There are several ways to detect a touch on a touch key.
Here we use the charging/discharging time of a simple RC circuit to measure touch event.

## Ingredients ##
In addition to things listed in Recipe 1 we require

* A wire

## Procedure ##

* Connect a wire to P1_5
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

**Arch_Capacitive_Touch** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_Capacitive_Touch)

~~~~{.cpp}
#include "mbed.h"

DigitalOut led(LED1);
DigitalInOut touch(P0_11);       // Connect a wire to P0_11
Ticker tick;

uint8_t touch_data = 0;         // data pool

void detect(void)
{
    uint8_t count = 0;
    touch.input();              // discharge the capacitor
    while (touch.read()) {
        count++;
        if (count > 4) {
            break;
        }
    }
    touch.output();
    touch.write(1);             // charge the capacitor
    
    if (count > 2) {
        touch_data = (touch_data << 1) + 1;
    } else {
        touch_data = (touch_data << 1);
    }
    
    if (touch_data == 0x01) {
        led = 1;                // touch
    } else if (touch_data == 0x80) {
        led = 0;                // release
    }
}

int main()
{
    touch.mode(PullDown);
    touch.output();
    touch.write(1);
    
    tick.attach(detect, 1.0 / 64.0);
    
    while(1) {
        // do something
    }
}

~~~~


# Recipe X: Time #

## Ingredients ##
In addition to things listed in Recipe 1 we require

* Grove - 4 Digit Display

## Procedure ##

* Connect Grove - Digit Display to UART Grove connector
* Build and upload the program to Arch platform. (follow procedure listed in Recipe 1)

**clock** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/clock)

~~~~{.cpp}
#include "mbed.h"
#include "DigitDisplay.h"

DigitDisplay display(P1_14, P1_13); // 4-Digit Display connected to UART Grove connector
DigitalOut led(LED1);
DigitalOut led2(LED2);
Ticker tick;
uint8_t hour = 0;
uint8_t minute = 0;
uint8_t second = 0;
uint8_t colon = 0;

uint8_t display_buffer[4] = {0, 0, 0, 0};

void handler(void)
{
    display.setColon(colon);
    led2 = !led2;
    if (colon) {
        colon = 0;
        
        second++;
        if (second >= 60) {
            second = 0;
            
            minute++;
            if (minute >= 60) {
                minute = 0;
                
                hour++;
                if (hour >= 24) {
                    hour = 0;
                }
            }
            

            display_buffer[0] = hour / 10;
            display_buffer[1] = hour % 10;
            
            display_buffer[2] = minute / 10;
            display_buffer[3] = minute % 10;
            
            display.write(display_buffer);
        }
    } else {
        colon = 1;
    }
}

int main() {
    display.write(display_buffer);
    tick.attach(handler, 0.5);
    while(1) {
        led = !led;
        wait(0.5);
    }
}

~~~~


# Recipe X: Working with USB Keyboard #
## Ingredients ##
In addition to things listed in Recipe 1, we require

* Grove - Button

## Procedure ##
* Connect Grove - Button to on-board grove connector marked UART.
* Build and upload the program to Arch platform. follow procedure listed in **Recipe 1**.

The following program demonstrates a USB keyboard with one button. Press the button to mute your computer and press CapsLock, NumLock or ScrollLock of your keyboard to turn on/off Arch's LEDs.

**Arch_USB_Keyboard_Ex1** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_USB_Keyboard_Ex1)

~~~~{.cpp}
#include "mbed.h"
#include "USBKeyboard.h"

//LED1: NUM_LOCK, LED2: CAPS_LOCK, LED3: SCROLL_LOCK
BusOut leds(LED1, LED2, LED3);
DigitalOut button(P1_14);               // Configure P1_14 pin as input
USBKeyboard keyboard;

int main() {
    int buttonPressedCount = 0; 
    
    while (!keyboard.configured()) {    // wait until keyboard is configured
    }
    
    while (1) {
        leds = keyboard.lockStatus();
        
        if (button.read()) {
            buttonPressedCount++;
            if (2 == buttonPressedCount) { // when button is pressed about 0.02s
                keyboard.mediaControl(KEY_MUTE); // send mute key
            }
        } else {
            buttonPressedCount = 0;
        }
        wait(0.01);
    }
}

~~~~

The following program implements an automatic input keyboard triggered by CapsLock key (for Windows). When the CapsLock key is pressed, a website is opened by IE.

**Arch_USB_Keyboard_Ex2** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_USB_Keyboard_Ex2)

~~~~{.cpp}
#include "mbed.h"
#include "USBKeyboard.h"
 
//LED1: NUM_LOCK, LED2: CAPS_LOCK, LED3: SCROLL_LOCK
BusOut leds(LED1, LED2, LED3);
USBKeyboard keyboard;
 
int main(void) {
    uint8_t caps;                       // status of CapsLock
    
    while (!keyboard.configured()) {    // wait until keyboard is configured
    }
 
    while (1) {
        leds = keyboard.lockStatus();
        caps = keyboard.lockStatus() & 0x2;
        
        // wait until CapsLock is pressed
        while ((keyboard.lockStatus() & 0x2) == caps) {
            leds = keyboard.lockStatus();
        }
        
        if (!caps) {
            keyboard.keyCode(KEY_CAPS_LOCK);    // lowercase input
        }
        
        // Automatic input
        keyboard.keyCode('r', 0x08);            // win + r
        wait(0.1);
        keyboard.puts("iexplore  http://seeedstudio.com\n\n");
    }
}
~~~~



