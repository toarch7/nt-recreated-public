var player = instance_random(Player)

if GameCont.area == 100 or (GameCont.area == 7 && GameCont.subarea == 3) {
	instance_destroy(); exit
}

if instance_exists(player) {
    var dir = 0,
		fine = false

    do {
        dir ++
        
		x = player.x
        y = player.y
        
		flip = choose(1, -1)
        
		x = player.x + random_spread(96, 120) * flip
        y = player.y + orandom(60)
		
		var flor = instance_nearest(x, y, Floor)
        
		x = flor.x + 16
        y = flor.y + 16
		
		//print(place_free(x, y), !place_meeting(x, y, Floor), place_meeting(x, y, Van), place_meeting(x, y, Portal), distance_to_object(VanSpawn))
		
		if position_empty(x, y) or !place_meeting(x, y, Floor) or place_meeting(x, y, Van)
		or place_meeting(x, y, Portal) or distance_to_object(VanSpawn) < 8
			continue
		
		print(distance_to_object(player), dir)
		
		if (distance_to_object(player) > 96 or dir > 250) {
			fine = true
			break
		}
    }
	until fine
}

instance_create(x, y, PortalClear)

image_speed = 0.4
alarm[0] = 40 + instance_number(VanSpawn) * 10

if GameCont.area == 101
	snd_play(sndOasisPopo)

else snd_play(sndVanWarning)