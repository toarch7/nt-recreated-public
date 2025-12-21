if lockstep_stop
	exit

if (hp <= 0) instance_destroy()

x = xstart
y = ystart
speed = 0

if x > 10016 {
    image_xscale = -1
    right = -1
}
else image_xscale = 1