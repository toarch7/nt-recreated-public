if image_xscale + growspeed < 1 {
    image_xscale += growspeed
    image_yscale += growspeed
}

if growspeed > -0.005 growspeed -= 0.0002
if image_xscale < 0.4 growspeed -= 0.01 image_angle += rot

if image_xscale < 0 instance_destroy()