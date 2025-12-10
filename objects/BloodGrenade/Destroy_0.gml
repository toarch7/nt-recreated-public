snd_play(sndMeatExplo)
snd_play(sndBloodLauncherExplo)

var _ang = random_angle

repeat (3) {
	scr_damage_create(x + ldrx(24, _ang), y + ldry(24, _ang), MeatExplosion)
	
	_ang += 120
	
	with (instance_create(x, y, BloodStreak)) image_angle = _ang
}