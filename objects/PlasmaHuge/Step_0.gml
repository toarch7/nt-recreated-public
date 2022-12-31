image_yscale = image_xscale
if image_xscale <= .5 instance_destroy()

instance_create(x + random_spread(16), y + random_spread(16), PlasmaTrail)
instance_create(x + random_spread(16), y + random_spread(16), PlasmaTrail)