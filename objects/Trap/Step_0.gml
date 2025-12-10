if lockstep_stop
	exit

if current_frame_active && fire > 0 && !instance_exists(Portal) {
    if side {
        if !position_meeting(x - 16 + 8, y, Wall) {
            with scr_projectile_create(x - 4, y + 8, TrapFire, 180, 6) hitid = other.hitid
        }

        if !position_meeting(x + 16 + 8, y, Wall) {
			with scr_projectile_create(x + 20, y + 8, TrapFire, 0, 6) hitid = other.hitid
        }
    }
	else {
        if !position_meeting(x + 8, y - 16, Wall) {
			with scr_projectile_create(x + 8, y - 4, TrapFire, 90, 6) hitid = other.hitid
        }

        if !position_meeting(x + 8, y + 16, Wall) {
			with scr_projectile_create(x + 8, y + 20, TrapFire, 270, 6) hitid = other.hitid
        }
    }
	
    fire --
}

if !position_meeting(x, y, Wall) instance_destroy()