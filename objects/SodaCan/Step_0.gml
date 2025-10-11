if z > 0 {
	zspeed -= 0.1
	
	if zspeed < 0 && (z + zspeed) <= 0 {
		zspeed = abs(zspeed) * 0.8
		snd_play(choose(sndCanBounce1, sndCanBounce2))
		if zspeed < 0.1 {
			zspeed = 0
		}
	}
}
else {
	friction = 0.2
}

z += zspeed