if instance_exists(GenCont) exit

if scrChestOpened()
	exit

var p = instance_nearest(x, y, Player)

if !p
	exit

snd_play(sndAmmoChest)

repeat 8
	instance_create(p.x, p.y, AmmoPickup)

instance_destroy()