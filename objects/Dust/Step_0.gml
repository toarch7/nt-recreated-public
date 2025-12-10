image_xscale += growspeed
image_yscale += growspeed

growspeed -= 0.02
image_angle += rot

if image_xscale < 0 instance_destroy()