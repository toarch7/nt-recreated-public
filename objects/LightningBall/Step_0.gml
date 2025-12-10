if lockstep_stop
	exit

if current_frame_active {
	scr_screenshake(2)
	
	if speed > 0.5 && GameCont.area == area_oasis && random(4) < 1 {
		instance_create(x, y, Bubble)
	}
	
	x += orandom(1)
	y += orandom(1)
	
	if random(4) < 1 {
		var _ammo = 5 * choose(1, 1, 1, 1, 2, 3)
	    scrLightningCreate(x, y, random_angle, _ammo)
	}
}

if (speed == 0) instance_destroy()