
letterbox = 0
step_complete = false

step_current ++

if (step_current == TutorialStep.Fin) alarm[0] = 45

if (step_current > TutorialStep.Fin && !instance_exists(Portal)) {
	save_set_value("game", "tutorial", false)
	instance_create(10016, 10016, Portal)
}

if step_current >= TutorialStep.NUM_TUTORIAL_STEPS {
	step_current = TutorialStep.NUM_TUTORIAL_STEPS - 1
	exit
}

if step_current == TutorialStep.PickingUp {
	var i = 0
	
	while (i < 256) {
		var f = instance_random(Floor)
		
		if ((++ i) >= 256) f = id
		
		if (!instance_exists(f)) continue
		
		with (f) {
			if (distance_to_object(Wall) < 64 || distance_to_object(hitme) < 32) continue
			
		    with instance_create(bbox_center_x, bbox_center_y, WeaponChest) {
				var ang = random_angle
				
				move_contact_solid(random_angle, 32 + random(72))
				
			    repeat 20 {
			        with instance_create(x, y, Dust)
						motion_add(ang, 6 - random(1))
					
			        ang += 18
			    }
				
				snd_play_hit(sndWeaponChest)
			}
			
			i = 256
		}
	}
}
