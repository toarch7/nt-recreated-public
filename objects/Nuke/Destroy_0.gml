snd_stop(snd)

snd_play_hit_big(sndNukeExplosion, 0.2)

var _ang = random_angle

repeat (8) {
    scr_damage_create(
		x + ldrx(12, _ang),
		y + ldry(12, _ang),
		Explosion)
    
	_ang += 60
}