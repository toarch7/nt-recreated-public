if lockstep_stop
	exit

if (hp <= 0) {
	instance_destroy()
	exit
}

if (sprite_index != sprSaplingAppear) {
	motion_add(direction, 0.2)
	motion_add(wantdir, 0.6)
	
	if (scrTargetIsVisible(target)) {
		motion_add(mcr_target_direction, 0.8)
	}
}
else if (alarm[0] < 2) alarm[0] = 2

if (speed > 4) speed = 4