if lockstep_stop
	exit

repeat 2
	instance_create(x, y, HPPickup)

snd_play(sndHealthChest)

instance_destroy()
