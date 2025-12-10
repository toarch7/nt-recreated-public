audio_stop_sound(snd)

snd_play_hit_big(sndBloodCannonEnd, 0.2)

instance_create(x, y, PortalClear)

var _ang = random_angle;

repeat (6) {
	scr_damage_create(
		x + ldrx(24, _ang),
		y + ldry(24, _ang),
		MeatExplosion)
	
	_ang += 60
}

with(instance_create(x, y, BloodStreak)) image_angle = _ang

with(instance_create(x, y, BloodStreak)) image_angle = _ang + 120

with(instance_create(x, y, BloodStreak)) image_angle = _ang + 240