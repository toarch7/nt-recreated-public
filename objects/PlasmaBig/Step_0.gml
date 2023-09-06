if lockstep_stop
	exit

image_yscale = image_xscale
if image_xscale <= .4 instance_destroy()

instance_create(x + orandom(12), y + orandom(12), PlasmaTrail)