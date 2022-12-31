var olddir, oldspeed;
olddir = direction
oldspeed = speed
move_bounce_solid(00)
motion_add(olddir, speed)
speed = oldspeed
if ((hspeed > 0) && (!place_free((x + hspeed), y))) {
    do {
        hspeed -= friction
    } until (place_free((x + hspeed), y) || (hspeed <= 0));

} else if ((hspeed < 0) && (!place_free((x + hspeed), y))) {
    do {
        hspeed += friction
    } until (place_free((x + hspeed), y) || (hspeed >= 0));

}
if ((vspeed > 0) && (!place_free(x, (y + vspeed)))) {
    do {
        vspeed -= friction
    } until (place_free(x, (y + vspeed)) || (vspeed <= 0));

} else if ((vspeed < 0) && (!place_free(x, (y + vspeed)))) {
    do {
        vspeed += friction
    } until (place_free(x, (y + vspeed)) || (vspeed >= 0));

}