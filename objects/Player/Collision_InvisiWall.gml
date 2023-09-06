if lockstep_stop
	exit

if !roll && race != 15 {
    move_contact_solid(direction, max(1, min(maxspeed, speed)))
    if !place_free(x + hspeed, y) {
        hspeed /= 2
        if !place_free(x + hspeed, y) hspeed = 0
    }
    if !place_free(x, y + vspeed) {
        vspeed /= 2
        if !place_free(x, y + vspeed) vspeed = 0
    }
} else {
    speed *= .3;
    move_bounce_solid(00)
}