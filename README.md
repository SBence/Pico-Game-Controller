# Pico-Game-Controller

This branch was developed with SDVX in mind. Capable of handling 7 LEDs, 1 WS2812B RGB strip, and 2 encoders.

Demo of this firmware running on Pocket SDVX Pico v4, purchasable at https://discord.gg/MmuKd73XbY

![Pocket SDVX Pico](demo.gif)

## About this fork

- Tested on and intended for [Pocket SDVX Pico v5](https://www.speedylabs.us/product/pocket-sdvx-pico-assembled/)

- Based on SpeedyPotato's [pocket-sdvx-pico-v5-develop](https://github.com/speedypotato/Pico-Game-Controller/tree/release/pocket-sdvx-pico-v5-develop) branch
  - nomouse mode from 4yn's [pocket-sdvx-pico-v5-develop-nomouse](https://github.com/4yn/Pico-Game-Controller/tree/release/pocket-sdvx-pico-v5-develop-nomouse) branch

### [Branches with additional features](https://github.com/SBence/Pico-Game-Controller/branches)

## Get the firmware

### [Firmware file downloads](https://github.com/SBence/Pico-Game-Controller/actions/workflows/build-firmware.yml)

1. Select the commit to download the firmware file of.
2. Under **Artifacts**, select **firmware**.

Refer to the [quick start guide](https://docs.google.com/document/d/1D9CUx3U4uje8LoN8qtBFXIQEj6s7Rs03GC2eq-TACfs) for installation instructions.

## Currently working/fixed

- Gamepad mode - default boot mode
- NKRO Keyboard & Mouse Mode - hold first button(gpio4) to enter kb mode
- HID LEDs with Reactive LED fallback
- ws2812b rgb on second core
- 2 ws2812b hid descriptor zones
- sdvx/iidx spoof - Tested on EAC - checkout branches release/pocket-sdvx-pico or release/pocket-iidx
- 1000hz polling
- Reversable Encoders with debouncing
- Switch debouncing
- Switch and LED pins are now staggered for easier wiring
- Fix 0-~71% encoder rollover in gamepad mode, uint32 max val isn't divisible evenly by ppr\*4 for joystick - thanks friends
- HID LEDs now have labels, thanks CrazyRedMachine
- refactor ws2812b into a seperate file for cleaner code & implement more RGB modes (added turbocharger mode) - hold second button (gpio 6) to swap to turbocharger mode; hold 9th button (gpio 20) to turn off RGB
- refactor debouncing algorithms into separate files for cleaner code

## TODO

- Store last mode in flash memory (probably implement into above TODO if possible) https://www.raspberrypi.org/forums/viewtopic.php?t=305570
- store configuration settings in a text file? consider implementing littlefs https://github.com/littlefs-project/littlefs https://www.raspberrypi.org/forums/viewtopic.php?t=313009 https://www.raspberrypi.org/forums/viewtopic.php?p=1894014#p1894014

## Building the firmware

- Setup the C++ environment for the Pi Pico as per https://datasheets.raspberrypi.org/pico/getting-started-with-pico.pdf
- Build pico-examples directory once to ensure all the tinyusb and other libraries are there. You might have to move the pico-sdk folder into pico-examples/build for it to play nice.
- Move pico-sdk back outside to the same level directory as Pico-Game-Controller.
- Open Pico-Game-Controller in VSCode(assuming this is setup for the Pi Pico) and see if everything builds.
- Tweakable parameters are in controller_config.h

## Thanks to

- Everyone in the Cons & Stuff Discord for providing near instant support to questions.
- https://github.com/hathach/tinyusb/tree/master/examples/device/hid_composite
- https://github.com/mdxtinkernick/pico_encoders for encoders which performed better than both interrupts and polling.
- My SE buddies who helped come up with a solution for the encoder rollover edge case scenario.
- https://github.com/Drewol/rp2040-gamecon for usb gamepad descriptor info.
- https://github.com/veroxzik/arduino-konami-spoof for konami spoof usb descriptor info.
- https://github.com/veroxzik/roxy-firmware for nkro descriptor and logic info.
- KyubiFox for bringing clkdiv to my attention for encoder debouncing
- 4yn for turbocharger lighting
- SushiRemover for alternate debounce mode
