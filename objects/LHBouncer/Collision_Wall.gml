if lockstep_stop
	exit

if bounce {
    instance_create(x, y, Dust)
    snd_play_hit(sndBouncerBounce)
    move_bounce_solid(true)
    bounce = false
	exit
}

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)
instance_destroy()