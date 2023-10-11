GameCont.popolevel++

var player = instance_nearest(x, y, Player)

if instance_exists(player) {
    do {
        x = player.x
        y = player.y
        
		ang = rng_random(8, 360)
        
		x = player.x + lengthdir_x(96 + rng_random(8, 96), ang)
		y = player.y + lengthdir_y(96 + rng_random(8, 96), ang)
        
		var dir = instance_nearest(x, y, Floor)
		
		if dir {
	        x = dir.x + 16
			y = dir.y + 16
	    }
	}
    until point_distance(x, y, player.x, player.y) > 64 and place_free(x, y)

}

image_speed = 0.4

alarm[0] = 40 + instance_number(IDPDSpawn) * 3

elite = 0

if (GameCont.loops > 1 && GameCont.area == 0) or (GameCont.loops && GameCont.area != 0) {
    elite = !rng_random(1, 5)
}

snd_play(qm(elite, sndEliteIDPDSpawn, sndIDPDPortalSpawn))