if lockstep_stop
	exit

instance_destroy()
instance_create(x, y, Dust)
snd_play_hit(sndHitWall, .2)

with instance_create(x, y, BulletHit)
sprite_index = sprIDPDBulletHit