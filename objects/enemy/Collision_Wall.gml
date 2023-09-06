if lockstep_stop
	exit

olddir = direction
oldspeed = speed
move_bounce_solid(00)

motion_add(olddir, speed)
speed = oldspeed

if hspeed > 0 and !place_free(x + hspeed, y) {
    do hspeed -= friction until place_free(x + hspeed, y) or hspeed <= 0
} else if hspeed < 0 and !place_free(x + hspeed, y) {
    do hspeed += friction until place_free(x + hspeed, y) or hspeed >= 0
}

if vspeed > 0 and !place_free(x, y + vspeed) {
    do vspeed -= friction until place_free(x, y + vspeed) or vspeed <= 0
} else if vspeed < 0 and !place_free(x, y + vspeed) {
    do vspeed += friction until place_free(x, y + vspeed) or vspeed >= 0
}