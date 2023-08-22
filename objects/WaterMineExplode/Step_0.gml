if image_index >= 3 && image_speed > 0 {
	depth = -7
}

if image_index >= 9 && !explode {
	instance_create(x + random(6) - 3, y - 8 + random(6) - 6, Explosion)
	instance_create(x, y + 6, Scorchmark)
	
	repeat 12
		instance_create(x, y, Bubble)
	
	var ang = random(360)
	
	repeat 16 {
		// we don't talk about it
	    with instance_create(x, y - 12, EnemyBullet3) {
	        motion_add(ang, 5 + random(7))
	        image_angle = direction
	        team = -1
	    }
		
	    ang += 360 / 16
	}
	
	snd_play(sndOasisExplosion)
	
	instance_destroy()
	
	depth = 0
}