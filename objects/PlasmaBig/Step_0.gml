image_yscale = image_xscale
if image_xscale <= .4 instance_destroy()

instance_create(x + random_spread(12), y + random_spread(12), PlasmaTrail)