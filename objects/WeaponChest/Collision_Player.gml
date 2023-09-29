if lockstep_stop
	exit

if !instance_exists(GenCont) {
	if scrChestOpened()
		exit

	if curse global.rng_state[3] += 1234
	
	var p = instance_nearest(x, y, Player)

	var pickup = instance_create(x, y, WepPickup)
	
	with pickup {
		scrDecideWep(1 + other.curse * 2)
				
		name = wep_name[wep]
		ammo = 1
		
		type = wep_type[wep]
		curse = other.curse
		
		sprite_index = wep_sprt[wep]
	}

	if GameCont.underwater
		snd_play(sndOasisChest)
	else if curse {
	    snd_play(sndCursedChest)
	    global.rng_state[3] -= 1234
	}
	else
		snd_play(sndWeaponChest)
	
	if p.race == 7 && p.ultra == 1 {
		with pickup {
			instance_copy(0)
			
			x = xprevious
			y = yprevious
		}
	}
	
	instance_destroy()
}

