if image_index < 1 {
	image_index += random(0.04)
}
else {
	image_index += 0.4
}

var player = noone,
	least = infinity,

if instance_number(Player) > 1 {
	with Player {
		if hp >= max_hp
			continue
		
		if hp < least {
			player = id
			least = hp
		}
	}
}
else player = instance_nearest(x, y, Player)

if instance_exists(player) {
	if distance_to_object(player) < 32 + (skill_get(3) * 64) or instance_exists(Portal) {
		var dir = point_direction(x, y, player.x, player.y)
		
		var xx = ldrx(6, dir)
		var yy = ldry(6, dir)
	
		if place_free(x + xx, y)
			x += xx
		
		if place_free(x, y + yy)
			y += yy
	}
}

if instance_exists(player) && place_meeting(x, y, Portal) {
	event_perform(ev_collision, Player)
}
