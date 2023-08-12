
letterbox = 0
doin = 0

if pos < array_length(text) {
	pos ++
	
	if pos == 4 {
	    alarm[0] = 45
	}
	else if global.desktop or UberCont.opt_gamepad {
	    alarm[0] = 45
	}
	
	if pos > 4 && !instance_exists(Portal) {
	    save_set_val("game", "tutorial", 0)
	    instance_create(10016, 10016, Portal)
	}
}

if pos == 1 {
	var i = 0
	
	while i < 256 {
		var f = instance_random(Floor)
		
		if (++ i) >= 256
			f = id
		
		if !instance_exists(f)
			continue
		
		with f {
			if distance_to_object(Wall) < 64 or distance_to_object(hitme) < 32
				continue
			
		    with instance_create(bbox_center_x, bbox_center_y, WeaponChest) {
				var ang = random(360)
				
				move_contact_solid(random(360), 32 + random(72))
				
			    repeat 20 {
			        with instance_create(x, y, Dust)
						motion_add(ang, 6 - random(1))
					
			        ang += 18
			    }
			}
			
			i = 256
		}
	}
}
