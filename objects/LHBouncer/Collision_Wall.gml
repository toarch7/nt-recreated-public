if lockstep_stop
	exit

if (bounce == 0) {
    instance_create(x, y, Dust)
    move_bounce_solid(00)
    snd_play_hit(sndBouncerBounce, 0.2)
    bounce = 1
} else {
    instance_destroy()
    instance_create(x, y, Dust)
    snd_play_hit(sndHitWall, 0.2)
}