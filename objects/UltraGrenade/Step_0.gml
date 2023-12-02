if lockstep_stop
	exit

attract_flash = lerp(attract_flash, 0, 0.1)

if !attract {
	
	if speed > 4 {
		alarm[0] = max(alarm[0], 60)
		alarm[2] = max(alarm[1], 6)
	}
	
	exit
}

if alarm[0] > flash_at {
	with hitme {
	    if distance_to_object(other) <= 32
			motion_add(point_direction(x, y, other.x, other.y), 2)
	}
	
	var ang = random_angle,
		len = 56 + random(8),
		xx = x + ldrx(len, ang),
		yy = y + ldry(len, ang)
	
	if place_meeting(xx, yy, Floor)
		instance_create(xx, yy, Dust)
}

if global.time % 3 > 0 {
	var cap = 6,
		accel = 2,
		dist = 32 + max(0, 90 - alarm[0]) / 2,
		rotation = (global.time) % 360
	
	with Dust {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel)
			motion_add(rotation, 1)
		}
	}
	
	with Smoke {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel)
			motion_add(rotation, 1)
		}
	}
	
	with Feather {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel)
			motion_add(rotation, 2)
		}
	}
	
	with Debris {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel)
			motion_add(rotation, 0.5)
		}
	}
	
	/*
	
	with Corpse {
		if speed < cap && distance_to_object(other) <= dist {
			motion_add(point_direction(x, y, other.x, other.y), accel / (1 + size / (size + 2)))
			
			if speed > 0 && !instance_is(self, CorpseActive) {
				var spr = sprite_index,
					img = image_index,
					spd = image_speed
				
				instance_change(CorpseActive, false)
				
				sprite_index = spr
				image_index = img
				image_speed = spd
			}
		}
	}
	
	*/
}