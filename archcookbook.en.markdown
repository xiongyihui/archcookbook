# Preface #

"Anyone can cook." - Gusteau's (a character in Ratatouille)

This cookbook is a starting point to work with Seeedstudio Arch platform. It introduces the platform with step by step examples by using Seeedstudio Grove modules. The cookbook is written with beginners in mind and assumes no prior experience in mbed API. This book expects a basic knowledge of C programming language. mbed API and programs are written C++ language. Although not essential to understand the programs, it is better you understand how to create an object for a class and how to use member functions.

If you are beginner, who is learning Embedded Systems and programming in C/C++ - import and execute the examples programs one by one by following the procedure listed in each recipe. You can skip all other fine details presented in the beginning.

Happy Programming :)

# Arch platform #

Seeedstudio Arch is a mbed enabled platform based on NXP's LPC11U24 microcontroller. This platforms comes with header pins whose footprint are compatible with Arduino shields. The two on-board Grove connectors can be interfaced with numerous Grove based sensors, actuators and display modules.

Arch platform can be easily programmed over USB using the LPC11U24's inbuilt ISP driver. Unlike mbed LPC11U24, Arch platform does not come with mbed interface chip. Hence, an additional Arch board has to be used to debug the target using CMSIS-DAP.


## Features ##

* Shields compatible header pins
* Two Grove connectors
* A large number of grove modules
* Drag-n-drop programming
* NXP LPC11U24 MCU
* Low power ARM Cortex-M0 Core
* 48MHz, 32KB Flash, 8KB RAM, 4KB EEPROM
* USB Device, 2xSPI, UART, I2C

## Pinout ##

![Arch V1.1 Pinout](figures/arch_v1.1_pinout.png)


# Recipe 7: Working with RTC #
## Ingredients ##
In addition to things listed in [Recipe 1][Arch Cookbook], we require

* Grove - Serial LCD
* Grove - RTC

## Procedure ##
* Connect Grove - Serial LCD to on-board grove connector marked UART.
* Connect Grove - RTC to on board grove connector markded I2C.
* Build and upload the program to Arch platform. follow procedure listed in **Recipe 1**.

The following program demonstrates a clock.

**Arch_GroveRTC_Ex1** - [Import to mbed online compiler](https://mbed.org/compiler/#import:https://mbed.org/users/yihui/code/Arch_GroveRTC_Ex1)

~~~~{.cpp}
#include "mbed.h"
#include "SerialLCD.h"
#include "ds1307.h"
 
SerialLCD lcd(P1_13, P1_14);  // Grove Serial LCD is connected to UART Tx and Rx pins
DS1307 rtc(P0_5, P0_4);    // Grove RTC is connected to I2C SDA(P0_5) and SCL(P0_4)
 
int main() {
    const char *week[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
    int sec, min, hour, day, date, month, year;
    char strBuffer[16];
    
    lcd.begin();
    lcd.print("Clock");
    rtc.start_clock();
    rtc.gettime(&sec, &min, &hour, &day, &date, &month, &year);
    if (0 == year) {
        rtc.settime(0, 0, 0, 4, 1, 1, 2014 % 100); // Jan 1st, 2014, Wed, 00:00:00
    }

    while(1) {
        rtc.gettime(&sec, &min, &hour, &day, &date, &month, &year);
        snprintf(strBuffer, sizeof(strBuffer), "%d-%d-%d  %s", 2000 + year, month, date, week[day]);
        lcd.setCursor(0, 0);
        lcd.print(strBuffer);
        snprintf(strBuffer, sizeof(strBuffer), "%d:%d:%d", hour, min, sec);
        lcd.setCursor(0, 1);
        lcd.print(strBuffer);
        wait(0.5);
    }
}



~~~~

# Recipe 8: Working with USB Keyboard #
## Ingredients ##
In addition to things listed in [Recipe 1][Arch Cookbook], we require

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

[Arch Cookbook]: http://mbed.org/users/viswesr/notebook/arch-cookbook/
