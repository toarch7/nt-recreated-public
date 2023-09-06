if lockstep_stop
	exit

move_bounce_solid(00)

hp -= 3
sprite_index = spr_hurt
image_index = 0

alarm[1] = 50