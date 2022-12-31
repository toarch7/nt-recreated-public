image_yscale = image_xscale
if image_xscale <= 0.5 instance_destroy()

if !irandom(1) instance_create(x + random_spread(8), y + random_spread(8), PlasmaTrail)