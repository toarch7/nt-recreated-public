if lockstep_stop
	exit

if speed > 6 && !snd_is_playing(sndShotgunHitWall) {
	snd_play(sndShotgunHitWall)
}

move_bounce_solid(00)
speed = min(18, speed * 0.8 + wallbounce)
instance_create(x, y, Dust)
wallbounce *= 0.9