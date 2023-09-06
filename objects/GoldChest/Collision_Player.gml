if lockstep_stop
	exit

if scrChestOpened()
	exit


with instance_create(x, y, WepPickup) {
	scrDecideWepGold(1)
	
	name = wep_name[wep]
	type = wep_type[wep]
	
	ammo = 1
	curse = 0
	
	sprite_index = wep_sprt[wep]
}

snd_play(sndWeaponChest)

instance_destroy()