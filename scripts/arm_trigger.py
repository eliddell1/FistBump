#!/usr/bin/env python

# arm_trigger.py

import os
import RPi.GPIO as GPIO
import time

import colorsys

from sys import exit

try:
    import numpy as np
except ImportError:
    exit("This script requires the numpy module\nInstall with: sudo pip install numpy")

import blinkt

# blinkt functions

blinkt.set_clear_on_exit()


def make_gaussian(fwhm):
    x = np.arange(0, blinkt.NUM_PIXELS, 1, float)
    y = x[:, np.newaxis]
    x0, y0 = 3.5, 3.5
    fwhm = fwhm
    gauss = np.exp(-4 * np.log(2) * ((x - x0) ** 2 + (y - y0) ** 2) / fwhm ** 2)
    return gauss

def puls():
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

puls()
time.sleep(1)


# Configure the GPIO pins

def fb_setup():
    global fb

    GPIO.setwarnings(False)
    GPIO.setmode(GPIO.BCM)

    # setup the pin to check the shutdown switch - use the internal pull down resistor
    GPIO.setup(fb['trigger'], GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
    GPIO.setup(fb['light'], GPIO.OUT)
    GPIO.output(fb['light'], True)
    GPIO.add_event_detect(fb['trigger'], GPIO.RISING, callback=fb_attack, bouncetime=300)


# Detect when the switch is pressed - wait shutdown_wait seconds - then shutdown

def fb_attack(channel):
    global fb
    fb['running'] = True
    print "BANG!"
    GPIO.output(fb['light'], False)
    os.system('sudo bash /home/pi/FistBump/fistbump.sh')
    exit()


# Close the log file, reset the GPIO pins
def fb_cleanup():
    global fb    
    GPIO.cleanup()



# Main --------------------------------------------


# Setup fb global variable array

fb = {}

# Specify which GPIO pins to use
fb['trigger'] = 3
fb['light'] = 2

# setup the GPIO pins and event triggers
fb_setup()

# Although the shutdown is triggered by an interrupt, we still need a loop
# to keep the script from exiting - just do a very long sleep

while True:
	num = len([f for f in os.listdir("/media/usb0")])
	while num > 0:
		print ("num:",num)
		puls()
		num = num -1
		print ("sleep")
	time.sleep(2)

#time.sleep(6000)

# clean up if the script exits without machine shutdown

fb_cleanup()






