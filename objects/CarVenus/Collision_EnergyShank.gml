if lockstep_stop
	exit

//MAGIC REPAIR
hp = 1000
instance_create(x, y, CarVenusFixed)
snd_play_loop(sndCarLoop)
screwed = 1
instance_destroy(id, 0)