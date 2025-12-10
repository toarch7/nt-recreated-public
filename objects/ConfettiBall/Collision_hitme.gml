if scr_projectile_generic_grenade_hit(false) {
	if (instance_exists(other) && other.hp > 0) exit
	
	repeat 30 {
        with instance_create(x, y, Confetti) {
            motion_add(random_angle, random(14))
            team = other.team
        }
    }
	
	var _snd = asset_get_index("sndConfetti" + string(irandom(6) + 1))
    if (!audio_exists(_snd)) _snd = sndConfetti1
    snd_play_hit_big(_snd, 0.2)
}