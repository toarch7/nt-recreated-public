if lockstep_stop
	exit

if current_frame_active && fire > 0 && !instance_exists(Portal) {
    if side {
        if !position_meeting(x - 16 + 8, y, Wall) {
            with scr_damage_create(x - 4, y + 8, TrapFire) hspeed = -6
        }

        if !position_meeting(x + 16 + 8, y, Wall) {
			with scr_damage_create(x + 20, y + 8, TrapFire) hspeed = 6
        }
    }
	else {
        if !position_meeting(x + 8, y - 16, Wall) {
			with scr_damage_create(x + 8, y - 4, TrapFire) vspeed = -6
        }

        if !position_meeting(x + 8, y + 16, Wall) {
			with scr_damage_create(x + 8, y + 20, TrapFire) vspeed = 6
        }
    }
	
    fire --
}

if !position_meeting(x, y, Wall) instance_destroy()