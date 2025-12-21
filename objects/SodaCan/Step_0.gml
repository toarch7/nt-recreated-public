if z > 0 {
	zspeed -= 0.2
	
	if (zspeed < 0 && (z + zspeed) <= 0) {
		if (bounce --) {
			zspeed = -zspeed * 0.6
			snd_play_hit(choose(sndCanBounce1, sndCanBounce2), 0.2)
		}
		else {
			friction = 0.2
			zspeed = 0
			z = 0
		}
	}
}

z += zspeed