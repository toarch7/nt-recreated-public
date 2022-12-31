image_xscale -= .1
x -= hspeed
y -= vspeed

instance_create(x, y, Dust)
snd_play_hit(sndHitWall, .2)