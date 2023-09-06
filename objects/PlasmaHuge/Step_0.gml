if lockstep_stop
	exit

image_yscale = image_xscale
if image_xscale <= .5 instance_destroy()

instance_create(x + orandom(16), y + orandom(16), PlasmaTrail)
instance_create(x + orandom(16), y + orandom(16), PlasmaTrail)