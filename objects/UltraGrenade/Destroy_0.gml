snd_play(sndExplosionL)

var _ang = random_angle

repeat 3 {
	scr_damage_create(
		x + lengthdir_x(16, _ang),
		y + lengthdir_y(16, _ang),
		GreenExplosion)
	
	_ang += 120
}

scrRadDrop(x, y, 8)