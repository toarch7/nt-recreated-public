if lockstep_stop
	exit

if instance_exists(GenCont) exit

var _player = instance_nearest(x, y, Player)
if !instance_exists(_player) exit

if scrChestOpened() exit

repeat (8) {
	instance_create(_player.x, _player.y, AmmoPickup)
}

snd_play(GameCont.underwater ? sndOasisChest : sndAmmoChest)

instance_destroy()