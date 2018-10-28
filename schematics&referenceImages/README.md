# Physical Build Instructions

The most difficult part of the phsyical assembly is the power on/off circut which is applied to the prototype board seen below.  In my setup the small black button is used for powering the device while the larger button is our trigger.

To fit in the 3d printable encloser included in this repo it is important to place these buttons in the exact positions seen on the images below.

__Top of proto board__

<img src="https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/proto_board_top.jpg" width="299" height="399">    

__Bottom of proto board__

<img src="https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/proto_board_bottom.jpg"  width="399" height="299">

Obviously it is hard to tell much from those images so I will say this, it would probably behoove you to first solder the header pins, best seen in the top image, to the proto board.  We won't actually use all of them but they will be used for the blinkt chip and the extra pins will give support.  The trigger button ( larger yellow button) is simple, it needs to be wired to the ground (small black wire on right of the bottom image) and GPIO 3 (small yellow wire).

For the power cycle circut reference the bread board image below. Note that the wires coming off our proto board will attach to the powerboot and are color coded (light blue is battery, light green is env, black is ground and white will be low battery)

<img src="https://raw.githubusercontent.com/eliddell1/FistBump/master/schematics%26referenceImages/powerbutton_powerboost_1000C.png" width="400" height="500">

<img src="https://raw.githubusercontent.com/eliddell1/FistBump/master/schematics%26referenceImages/powerbutton_powerboost_500C.png" width="400" height="500">

Once that proto board is all wired and soldered the rest is quite simple. And can be explained with the pics below.

We attache the pi zero to the zero4u usb hat like so:

<img src="https://raw.githubusercontent.com/eliddell1/FistBump/master/schematics%26referenceImages/pi%2Busb_top.jpg" width-"300" height="400">
<img src="https://raw.githubusercontent.com/eliddell1/FistBump/master/schematics%26referenceImages/pi%2Busb_bottom.jpg" width-"300" height="400">
