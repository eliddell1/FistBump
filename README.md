# FistBump

<img src="https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/headshot.jpg" width="300" height="400">

## Introduction
When performing a typical deauth/wpa 4way handshake attack, one must get close enough to the target/clients for the deauth and capture to be effective. This can prove difficult in a typcial engagement, as one would draw suspicion setting up a laptop with a big wifi adapter sticking out and a bunch of terminal windows open.  It just screams hacker right? 

But what if you had a portable device that could launch such an attack with the click of a single button, while being small enough to be comfortably hidden in your hacker hoody pocket. A device with a low profile wifi adapter and removable storage where the handshakes are automatically stored so that you can easily transfer them to your hashcat rig when you get home. FistBump is a prototype of such a device. Did I mention it charges with a standard mini usb charger? Well it does.

__UPDATES__

As of __Version 2.0__ it will now also capture PMKID hashes as well. I migrated from aircrack to hcxdumptool.  I have left the old
fistbump.sh which utilizes the aircrack method in the repository incase for some reason someone wants that, but now the attack script is wpa_hashgrab.sh. _(It not only adds the capability to capture the PMKID hashes as well as 4 way handhsakes but its also much faster and a cleaner execution overall)_

As of __Version 2.1__ you can now target specific networks by saving a file named targets.txt to the removable USB drive with the BSSID(s) of your target(s) minus the colons. For instance, if your target BSSID is XX:XX:XX:XX:XX:XX, your targets.txt file will say XXXXXXXXXXXX. For multiple targets just put each BSSID on a new line.  HcxDumptool supports up to 64 specific targets. To revert back to a broad untargeted attack, simply remove the targets.txt file from your removable storage.

## Using FistBump

To power on FistBump, hold down the small button for about a second or until the red light on the bottom of the device goes off.  When the device is ready it will show either a __single green light__ or a __blue pulsing pattern__ on the strip of leds at the top of the device. Both indicate that the device is armed and ready to attack. The __single green light__ simply means there are currently no hashes stored on the device, while the __blue pulsing pattern__ indicates how many hash files are currently saved on the device. 

_Note: (pulse, pulse, pause, repeat) would mean 2 hash files are saved. Hash files can contain more than one hash and from more than one network. The hash files are saved to the external usb drive with the naming convention {date_time_Captured}.{hashcat mode}. For example, 4 way handshakes are cracked using `$ hashcat -m 2500... `, so a file containing 4 way handshakes would be named 201810290107.2500 while a PMKID hash file captured from the same attack would be 201810290107.16800, as the hashcat mode forcracking PMKID is 16800._  As of Version 2.1 if you specified a target (see updates section for v2.2), the captured hashes will be prepended with "targeted_" example: targted_201810290107.2500

### Starting an Attack 

To start an attack simply press the larger button.   

Before the actual attack begins, FistBump will make sure you have a USB thumb drive attached, where it will store the hashes it collects.  If no USB drive is present. it will light the strip up __solid red__ to indicate the missing drive and abort, sending you back to the ready state mentioned above.  Don't worry, you can simply insert your USB thumbdrive and try again. 

With a thumb drive present it will begin by putting your wifi adapter into the proper state, monitor mode, and kill any processes, like wpa_supplicant, that may interfere.  This stage will be indicated by a __purple scan pattern__. 

When you see a __random flashing rainbow pattern__ or __random flashing purple pattern__, the attack has begun! 
The Rainbow pattern indicates you are doing a broad attack while the purple pattern indicates that you have specified a target (see updates section for v2.1)

The attack leverages the latest WPA/WPA2 attack tool, [hcxdumptool](https://hashcat.net/forum/thread-7717.html) and is set to run for 40 seconds, which in my experience should be plenty of time to at least grab some handshakes.  If you wish to change this, you can edit the wpa_hashgrab.sh script found in scripts/FistBump/hashgrab.sh of this repository or in /home/pi/FistBump/ on the actual pi.

When the attack is complete you will see the strip of LEDs light up __solid purple__ if new hashes were collected during the attack, or __solid yellow__ if no new hashes were collected.

Now one might say, _"If I'm trying to be stealthy, whats with all these beautiful flashy LEDs?"_  Thats a valid point.  Again,
this is merely a proof of concept, but should you really have the need, the LED strip can be easily removed and replaced with out any altercations to the code. Of course then you just have to assume your attack went through and completed as you will have no indication.

### Powering Down

To power off FistBump, simply press the small power button again. The device will flash __solid yellow__ indicating a shutdown has begun.  Once all lights, external and internal are off, the device is off. The device will also begin a shutdown on its own when the battery gets dangerously low. This will also be indicated by the __solid yellow__ indicator and may come unexpectedly. Don't be alarmed as it is for the safety and integrety of the device img.

## Disclaimer

_This Device was developped as a proof of concept and for White Hat Purposes.  You should only use this device on your own or a consenting network and in a controlled enviroment, as sending the necessary deauth packets used in the contained scripts could be illegal in your given part of the world. I do not endorse or warrent breaking the law or invading the privacy of others. You alone are fully responsible for what you do with this info/device, and how you use it. I am not responsible for your actions. Please do not hack Wifi points that you are not allowed to!!!
Don't be a jerk!_

## What is here?
This repository contains all the Schematics, Reference Photos, Boot images, scripts, and even 3d printable encloser parts for creating a FistBump prototype device.

## Parts List

* [1 pi zero v1.3](https://www.raspberrypi.org/products/raspberry-pi-zero/)
_Do **NOT** use the wifi model as the chip doesn't support monitor/package injection and creates interferience on usb hub_

* [1 zero4u usb hub adapter](https://www.adafruit.com/product/3298?gclid=Cj0KCQjw6rXeBRD3ARIsAD9ni9CGzOos99HaKls0MxgqrZMt_sKTnR6LVGsSJiN6rdDrbmr9ndM0L3QaAk_SEALw_wcB)

* [1 MakerSpot RPi Raspberry Pi Zero W Protoboard Breadboard](https://www.amazon.com/MakerSpot-Raspberry-Protoboard-Breadboard-Prototyping/dp/B01J9ILH7S)

* [2 10k resistors](https://www.amazon.com/Projects-25EP51410K0-10K-Resistors-Pack/dp/B01F06T56I/ref=sr_1_1_sspa?ie=UTF8&qid=1540222052&sr=8-1-spons&keywords=10k+resistor&psc=1)

* [1 100k resistor](https://www.amazon.com/Projects-25EP514100K-100k-Resistors-Pack/dp/B0185FCGEY/ref=sr_1_1_sspa?ie=UTF8&qid=1540222085&sr=8-1-spons&keywords=100k+resistor&psc=1)

* [3 1N4007 diodes]( https://www.amazon.com/100-Pieces-1N4007-Rectifier-Electronic/dp/B079KBFKK5/ref=sr_1_1_sspa?ie=UTF8&qid=1540222123&sr=8-1-spons&keywords=1n4007+diode&psc=1)

* 1 [small momentary button for power button](https://www.amazon.com/GZFY-6x6x4-5mm-Momentary-Tactile-Button/dp/B01N6GU7TA/ref=sr_1_14?ie=UTF8&qid=1540222185&sr=8-14&keywords=small+momentary+button)

* 1 [regular momentary button for Attack Trigger](https://www.amazon.com/Cylewet-12x12x7-3mm-Momentary-Tactile-Arduino/dp/B01NCQVGLC/ref=sr_1_9?ie=UTF8&qid=1540222185&sr=8-9&keywords=small+momentary+button)

* 1 [2.5 pi nylon screw set](https://www.adafruit.com/product/3299)

* 1 usb wifi adapter capable of monitor mode/ packet injection. I'd recommend the [Panda 300Mbps Wireless N USB Adapter](https://www.amazon.com/gp/product/B00EQT0YK2/ref=oh_aui_detailpage_o01_s00?ie=UTF8&psc=1) or even the [canaKit Wifi adapter](https://www.amazon.com/gp/product/B00GFAN498/ref=oh_aui_detailpage_o00_s01?ie=UTF8&psc=1) _both are capable of packet injection and fairly small YAY!_ or you could also use [this guy if you want and even smaller profile but its not as strong]( https://www.amazon.com/gp/product/B019XUDHFC/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1) 
For a more complete list of recommended devices [click here](https://null-byte.wonderhowto.com/how-to/buy-best-wireless-network-adapter-for-wi-fi-hacking-2018-0178550/)

* 1 [lo profile sandisk flash storage for saving handshakes in a removable manner](https://www.amazon.com/SanDisk-Cruzer-Low-Profile-Drive-SDCZ33-008G-B35/dp/B005FYNSUA/ref=sr_1_7?s=electronics&ie=UTF8&qid=1540222662&sr=1-7&keywords=sandisk+flash+drive+8gb)

* 1 [16-32gb class 10 mirco sd card for pi boot image](https://www.amazon.com/s/ref=nb_sb_ss_i_5_10?url=search-alias%3Delectronics&field-keywords=16gb+micro+sd+card+class+10&sprefix=16gb+micro%2Celectronics%2C132&crid=5DO4BAWIZ2SP)

* 1 [Pwerboost 1000c or 500c](https://www.adafruit.com/product/2465)

* 1 [3.7V 1200mAh PKCELL LP503562](https://www.amazon.com/s?k=3.7V+1200mAh+PKCELL+LP503562&ref=nb_sb_noss) _size matters we want a low profile as we will have a tight fit but feel free to alter this as you see fit espcially if you deisgn your own enclosuer etc_

* 1 [Pimoroni Blinkt!](https://shop.pimoroni.com/products/blinkt) _this will be your status indicator_

## Physical Assembly
For instructions on the physical assmebly follow the README file, [here](https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/README.md).  

I have also supplied freecad/stl files for the 3d printable encloser [here](https://github.com/eliddell1/FistBump/tree/master/EncloserFreeCad).

## Software Dependencies
This repository will supply a disk image built off [Raspbian STRETCH OS](https://github.com/eliddell1/FistBump/releases) in the releases section, that you can just write to a micro sd, pop into your piZero and be good to go! __username:pi password: fistbump__ That said, should you choose to build this yourself off of another OS or with modifications, be aware of the following dependencies.  The scripts for powering on and off the device as well as the attack button and actual attack have been suplied in the [scripts folder](https://github.com/eliddell1/FistBump/tree/master/scripts)

I chose to start the "arm_trigger" python script @reboot in crontab and the lipopi python script (for powering on and off the device) is set to start via /etc/rc.local

### version 1 dependencies

* aircrack-ng
`sudo apt install aircrack-ng`

* cowpatty
`wget http://www.willhackforsushi.com/code/cowpatty/4.6/cowpatty-4.6.tgz
tar zxfv cowpatty-4.6.tgz
cd cowpatty-4.6
make cowpatty
sudo cp cowpatty /usr/bin`

### version 2 dependencies 
* [hcxdumptool v4.2.0 or higher](https://github.com/ZerBea/hcxdumptool)

* [hcxtools v4.2.0 or higher](https://github.com/ZerBea/hcxtools)

### indicator depenencies
* blinkt! python library
`curl https://get.pimoroni.com/blinkt | bash`

## Credits
Credit where credit is due: 

* [ZerBera](https://github.com/ZerBea) for their development of hcxdumtool and hcxtools used in this prototype

* The powering on/off schematic and script were designed by [NeonHorizon](https://github.com/NeonHorizon/lipopi/blob/master/README.power_up_power_down.md)  

* Call out to 'atom' of the hashcat forums for this post: https://hashcat.net/forum/thread-7717.html

* special call out to icarus255 and the rest of the [Hak5 Community](https://forums.hak5.org) for being inspirational and all that.
 

