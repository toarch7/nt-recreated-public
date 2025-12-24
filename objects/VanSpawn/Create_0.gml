var player = instance_random(Player)

if GameCont.area == area_vault || (GameCont.area == area_palace && GameCont.finalsubarea) {
	instance_destroy()
	exit
}

if instance_exists(player) {
    var dir = 0, fine = false

    do {
		flip = choose(1, -1)
        
		x = player.x + random_range(96, 120) * flip
        y = player.y + orandom(60)
		
		with (instance_nearest(x, y, Floor)) {
			other.x = bbox_center_x
			other.y = bbox_center_y
		}
		
		if (position_empty(x, y) || !place_meeting(x, y, Floor) || place_meeting(x, y, Van)
			|| place_meeting(x, y, Portal) || distance_to_object(VanSpawn) < 8
		) {
			continue
		}
		
		if (distance_to_point(player.x, player.y) > 96) {
			fine = true
			break
		}
    }
	until (fine || (++ dir) >= 250)
}

instance_create(x, y, PortalClear)

image_speed = 0.4
alarm[0] = 40 + instance_number(VanSpawn) * 10

snd_play(GameCont.underwater ? sndOasisPopo : sndVanWarning)