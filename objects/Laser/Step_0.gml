if lockstep_stop
	exit

image_yscale -= 0.25
if image_yscale < 0 instance_destroy()

img += 0.5