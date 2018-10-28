# Physical Build Instructions

The most difficult part of the phsyical assembly is the power on/off circut which is applied to the prototype board seen below.  In my setup the small black button is used for powering the device while the larger button is our trigger.

To fit in the 3d printable encloser included in this repo it is important to place these buttons in the exact positions seen on the images below.

__Top of proto board__

<img src="https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/proto_board_top.jpg" alt="alt text" width="299" height="399">    

__Bottom of proto board__

<img src="https://github.com/eliddell1/FistBump/blob/master/schematics%26referenceImages/proto_board_bottom.jpg" alt="alt text" width="399" height="299">

Obviously it is hard to tell much from those images so i will say this.  It would probably behoove you to first solder the header pins to seen in the top image.  We won't use all of them but they will be used for the blinkt chip and the extra pins will give support.  The trigger button is simple, it needs to be wired to the ground (small black wire on right of the bottom image) and GPIO 3 (small yellow wire).

For the power cycle circut reference the bread board image below. Note that the wires coming off our bread board are color coded and will attach to the powerboost 500 or 1000 depending on which you have.




