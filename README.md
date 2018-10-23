# **__STILL PUTTING THIS TOGETHER STAY TUNED__**

# FistBump
ProtoType for a handheld device used to grab WPA four way handshakes

## Overview
This repository contains (UNDER CONSTRUCTION) all the Schematics, Reference Photos, Boot images, scripts, and even 3d printable encloser parts for creating what i am affectionitly calling "FistBump," a handheld device used to capture WPA/WPA2
4 way handshakes and storing them to removable storage so that the can be bruteforced later.

## Disclaimer
_This Device was developped as a proof of concept and for White Hat Purposes.  You should only use this device on your own or a consenting network and in a controlled enviroment as sending the necessary deauth packets used in the contained scripts could be illegal in your given part of the world. I do not endorse or warrent breaking the law or invading the privacy of others. What you do with this information is up to you. You alone are fully responsible for what you do with this info, and how you use it. I am not responsible for your actions. Please do not hack Wifi points that you are not allowed to!!!
Don't be a jerk!_

## Parts List

* [1 pi zero v1.3](https://www.raspberrypi.org/products/raspberry-pi-zero/)
**__Don't use the wifi model as the chip doesn't support monitor/package injection and creates interferience on usb hub__**

* [1 zero4u usb hub adapter](https://www.adafruit.com/product/3298?gclid=Cj0KCQjw6rXeBRD3ARIsAD9ni9CGzOos99HaKls0MxgqrZMt_sKTnR6LVGsSJiN6rdDrbmr9ndM0L3QaAk_SEALw_wcB)

* [1 MakerSpot RPi Raspberry Pi Zero W Protoboard Breadboard](https://www.amazon.com/MakerSpot-Raspberry-Protoboard-Breadboard-Prototyping/dp/B01J9ILH7S)

* [2 10k resistors](https://www.amazon.com/Projects-25EP51410K0-10K-Resistors-Pack/dp/B01F06T56I/ref=sr_1_1_sspa?ie=UTF8&qid=1540222052&sr=8-1-spons&keywords=10k+resistor&psc=1)

* [1 100k resistor](https://www.amazon.com/Projects-25EP514100K-100k-Resistors-Pack/dp/B0185FCGEY/ref=sr_1_1_sspa?ie=UTF8&qid=1540222085&sr=8-1-spons&keywords=100k+resistor&psc=1)

* [3 1N4007 diodes]( https://www.amazon.com/100-Pieces-1N4007-Rectifier-Electronic/dp/B079KBFKK5/ref=sr_1_1_sspa?ie=UTF8&qid=1540222123&sr=8-1-spons&keywords=1n4007+diode&psc=1)

* 1 [small momentary button for power button](https://www.amazon.com/GZFY-6x6x4-5mm-Momentary-Tactile-Button/dp/B01N6GU7TA/ref=sr_1_14?ie=UTF8&qid=1540222185&sr=8-14&keywords=small+momentary+button)

* 1 [regular momentary button for Attack Trigger](https://www.amazon.com/Cylewet-12x12x7-3mm-Momentary-Tactile-Arduino/dp/B01NCQVGLC/ref=sr_1_9?ie=UTF8&qid=1540222185&sr=8-9&keywords=small+momentary+button)

* 1 [2.5 pi nylon screw set](https://www.adafruit.com/product/3299)

* 1 [canaKit Wifi adapter](https://www.amazon.com/gp/product/B00GFAN498/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1) capable of packet injection and small YAY!) or you could also use [this guy though if you want and even smaller profile but its not as strong]( https://www.amazon.com/gp/product/B019XUDHFC/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1)

* 1 [lo profile sandisk flash storage for saving handshakes in a removable manner](https://www.amazon.com/SanDisk-Cruzer-Low-Profile-Drive-SDCZ33-008G-B35/dp/B005FYNSUA/ref=sr_1_7?s=electronics&ie=UTF8&qid=1540222662&sr=1-7&keywords=sandisk+flash+drive+8gb)

* 1 32gb class 10 mirco sd card for pi boot image

* 1 [Pwerboost 1000c or 500c](https://www.adafruit.com/product/2465)

* 1 [LiPo rechargable 3.7v 1200mAh battery] (https://www.amazon.com/Battery-Packs-Lithium-Polymer-1200mAh/dp/B00J2QET64/ref=sr_1_5?s=electronics&ie=UTF8&qid=1540227974&sr=1-5&keywords=lipo+battery)

* 1 [Pimoroni Blinkt!](https://shop.pimoroni.com/products/blinkt) __this will be your status indicator__

# Software Dependencies
This repository will supply a ready to go image that you could just write to micro sd or should you choose to build this yourself be aware of the following dependencies

* aircrack-ng
`sudo apt install aircrack-ng`

* cowpatty 
`wget http://www.willhackforsushi.com/code/cowpatty/4.6/cowpatty-4.6.tgz
tar zxfv cowpatty-4.6.tgz
cd cowpatty-4.6
make cowpatty
sudo cp cowpatty /usr/bin`

# **__TO BE CONTINUED UNDER CONSTRUCTION__**
