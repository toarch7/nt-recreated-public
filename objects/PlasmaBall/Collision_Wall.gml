if lockstep_stop
	exit

image_xscale -= 0.1
image_yscale -= 0.1

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)