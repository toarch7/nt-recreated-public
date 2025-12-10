if lockstep_stop
	exit

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)
instance_destroy()