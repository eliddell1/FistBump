#!/usr/bin/env python

# arm_trigger.py
# Handles the ready and armed state of the FistBump device
# This script is started @reboot in crontab

# 2018 - Erik Liddell - Freely Distributed under MIT License

import os
import RPi.GPIO as GPIO
import time
import fnmatch
import colorsys

from sys import exit

try:
    import numpy as np
except ImportError:
    exit("This script requires the numpy module\nInstall with: sudo pip install numpy")

import blinkt

# blinkt functions

blinkt.set_clear_on_exit(True)

def make_gaussian(fwhm):
    x = np.arange(0, blinkt.NUM_PIXELS, 1, float)
    y = x[:, np.newaxis]
    x0, y0 = 3.5, 3.5
    fwhm = fwhm
    gauss = np.exp(-4 * np.log(2) * ((x - x0) ** 2 + (y - y0) ** 2) / fwhm ** 2)
    return gauss

def puls():
    global fb
    if fb['running']:
        #print('killing lights')
        blinkt.clear()
        return
    for z in list(range(1, 10)[::-1]) + list(range(1, 10)):
        fwhm = 5.0/z
        gauss = make_gaussian(fwhm)
        start = time.time()
        y = 4
        for x in range(blinkt.NUM_PIXELS):
            h = 0.5
            s = 1.0
            v = gauss[x, y]
            rgb = colorsys.hsv_to_rgb(h, s, v)
            r, g, b = [int(255.0 * i) for i in rgb]
            blinkt.set_pixel(x, r, g, b, .1)
        blinkt.show()
        end = time.time()
        t = end - start
        if t < 0.04:
            time.sleep(0.04 - t)


# Configure the GPIO pins

def fb_setup():
    global fb

    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)

    # setup the pin to check the shutdown switch - use the internal pull down resistor
    GPIO.setup(fb['trigger'], GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.add_event_detect(fb['trigger'], GPIO.RISING, callback=fb_attack, bouncetime=300)


# Detect when the switch is pressed - wait shutdown_wait seconds - then shutdown

def fb_attack(channel):
    global fb
    fb['running'] = True
    print ("BANG!")
    blinkt.clear()
    os.system('sudo sh /home/pi/FistBump/wpa_hashgrab.sh')
    exit()


# Close the log file, reset the GPIO pins
def fb_cleanup():
    global fb
    #GPIO.cleanup()


# Main --------------------------------------------


# Setup fb global variable array

fb = {}
fb_cleanup()
# Specify which GPIO pins to use
fb['trigger'] = 3
fb['running'] = False
# setup the GPIO pins and event triggers
fb_setup()



# Although the shutdown is triggered by an interrupt, we still need a loop
# to keep the script from exiting - just do a very long sleep

while fb['running'] != True:
	num = len(fnmatch.filter(os.listdir("/media/usb0"),'*.2500')) + len(fnmatch.filter(os.listdir("/media/usb0"),'*.16800'))
	if num > 0:
		while num > 0:
			print ("num:",num)
			puls()
			num = num -1
			print ("sleep")
	else :
		blinkt.set_pixel(1, 0, 255, 0, .1)
		blinkt.show()
	time.sleep(2)



# clean up if the script exits without machine shutdown

#fb_cleanup()

puls()
time.sleep(1)



