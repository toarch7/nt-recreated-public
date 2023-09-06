if lockstep_stop
	exit

if scrChestOpened()
	exit

hp = 0

snd_play(sndAmmoPickup)
