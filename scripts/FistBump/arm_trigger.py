#!/usr/bin/env python

# arm_trigger.py

import os
import RPi.GPIO as GPIO
import time

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
    time.sleep(6000)

# clean up if the script exits without machine shutdown

fb_cleanup()






