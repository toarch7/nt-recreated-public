if lockstep_stop
	exit

if image_index < 1
image_index += random(0.04)
else
image_index += 0.4

var player = instance_nearest(x, y, Player)

if instance_exists(player) {
	if point_distance(x,y,player.x,player.y) < 32 + (skill_get(3) * 64) or instance_exists(Portal) {
		var dir = point_direction(x, y, player.x, player.y),
			xx = ldrx(6, dir),
			yy = ldry(6, dir)
		
		if place_free(x + xx, y)
			x += xx
		
		if place_free(x, y + yy)
			y += yy
	}
}

if instance_exists(player) && place_meeting(x, y, Portal) {
	var least = 100,
		player = noone
	
	with Player {
		if race == 12 && rogue_ammo < least {
			least = rogue_ammo
			player = id
		}
	}
	
	if instance_exists(player) {
		x = player.x
		y = player.y
	}
	
    event_perform(ev_collision, Player)
}

