if lockstep_stop
	exit

if (alarm[0] >= 5 && current_frame_active) {
    with instance_create(
		random_range(bbox_left, bbox_right),
		random_range(bbox_top + 20, bbox_bottom - 10),
		choose(Explosion, Explosion, GreenExplosion)
	) {
        hitid = other.hitid
    }
    
	if (!soundplayed) {
		snd_play_hit_big(sndExplosionS, 0.2)
		soundplayed = true
	}
	else {
		soundplayed = false
	}
}

with projectile {
    if (team == other.team) instance_destroy()
}

instance_destroy(Guardian)