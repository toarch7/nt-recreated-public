if lockstep_stop
	exit

image_xscale -= 0.1
instance_create(x, y, Dust)
snd_play_hit(sndHitWall, 0.2)

x -= hspeed
y -= vspeed