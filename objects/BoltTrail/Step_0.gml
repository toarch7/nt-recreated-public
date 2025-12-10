if lockstep_stop
	exit

image_yscale -= 0.2
if image_yscale < 0 instance_destroy()