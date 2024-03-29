if lockstep_stop
	exit

if !instance_exists(GenCont) {
	if scrChestOpened()
		exit
	
	var p = instance_nearest(x, y, Player)
	
	random_set_seed(dropseed)
	
	GameCont.nochest = 0
	instance_create(x, y, PortalClear)
	
	repeat 3 + (p.race == 7 && p.ultra == 1) {
		with instance_create(x + 8, y, WepPickup) {
			scrDecideWep(1)
			
			sprite_index = wep_sprt[wep]
			name = wep_name[wep]
			type = wep_type[wep]
			
			ammo = 1
			curse = 0
		}
	}

	snd_play(sndBigWeaponChest)
	snd_play(p.snd_chst)
	
	instance_destroy()
}

