if lockstep_stop
	exit

move_bounce_solid(true)
move_outside_solid(point_direction(other.x + 8, other.y + 8, x, y), 2)
if (speed > 4 && mask_index != mskWepPickup) snd_play_hit(sndHitWall)
if (friction == 0) friction = 0.5
speed *= 0.4