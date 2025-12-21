if lockstep_stop
	exit

if race == Race.Frog {
	if (distance_to_object(Campfire) > 600) {
		spr_to = sprMutant15Sit
		spr_from = sprMutant15Sit
		spr_slct = sprMutant15Sit
		spr_menu = sprMutant15Sit
		spr_dead = sprMutant15Sit
		
		if (sprite_index == sprMutant15Walk) {
			sprite_index = sprMutant15GoSit
			speed = 0
		}
		else if (sprite_index == sprMutant15GoSit) {
			if (animation_end) image_index = sprMutant15Sit
		}
	}
	else {
	    sprite_index = sprMutant15Walk
	    speed = 3
		
		friction = 0.4
		
	    if (hspeed != 0) image_xscale = sign(hspeed)
	
		instance_deactivate_object(id)
		var _instance = instance_nearest(x, y, CampChar)
		instance_activate_object(id)
		
	    if instance_exists(_instance) {
	        if _instance.y > y {
	            depth = _instance.depth + 1
	        }
			else {
				depth = _instance.depth - 1
			}
		}
	}
	
	if instance_exists(Menu) && Menu.race == Race.Frog && random(5) < 1 {
		with (instance_create(
			random_range(bbox_left, bbox_right),
			random_range(bbox_top, bbox_bottom),
			CaveSparkle)
		) {
			depth = other.depth - choose(0, 1)
		}
	}
}