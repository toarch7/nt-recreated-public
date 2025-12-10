if bounce {
    bounce = false
    move_bounce_solid(00)
    instance_create(x, y, Dust)
	snd_play_hit(sndBouncerBounce)
    exit
}

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)
instance_destroy()