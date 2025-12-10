if lockstep_stop
	exit

if speed == 0 exit

snd_play_hit_big(sndBoltHitWall, 0.2)
move_contact_solid(direction, 16)
instance_create(x, y, Dust)
speed = 0

alarm[0] = 30
alarm[1] = 1
