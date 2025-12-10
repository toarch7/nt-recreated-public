snd_stop(snd)
snd_play(sndExplosionL)

var _ang = random_angle

repeat (2) {
	instance_create(
		x + ldrx(12, _ang),
		y + ldry(12, _ang),
		Explosion)
	
	_ang += 180
}