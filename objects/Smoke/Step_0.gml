image_xscale += growspeed
image_yscale += growspeed

growspeed -= 0.001
image_angle += rot

if image_xscale < 0 or instance_exists(Spiral)
	instance_destroy()

if global.time % 3 == 0 && position_meeting(x, y, Wall)
	move_bounce_solid(true)