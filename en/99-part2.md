# Recipe X: Working with USB Keyboard #
## Ingredients ##
In addition to things listed in Recipe 1, we require

* Grove - Button

## Procedure ##
* Connect Grove - Button to on-board grove connector marked UART.
* Build and upload the program to Arch platform. follow procedure listed in **Recipe 1**.

The following program demonstrates a USB keyboard with one button. Press the button to mute your computer and press CapsLock, NumLock or ScrollLock of your keyboard to turn on/off Arch's LEDs.

[!program](users/yihui/code/Arch_USB_Keyboard_Ex1)

The following program implements an automatic input keyboard triggered by CapsLock key (for Windows). When the CapsLock key is pressed, a website is opened by IE.

[!program](users/yihui/code/Arch_USB_Keyboard_Ex2)

