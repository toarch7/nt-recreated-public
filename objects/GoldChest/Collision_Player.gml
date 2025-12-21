if lockstep_stop
	exit

if scrChestOpened()
	exit

var _wep = scrDecideWepGold()
scrWeaponPickupCreate(x, y, _wep, true)

snd_play(sndGoldChest)

instance_destroy()