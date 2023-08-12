var p = instance_nearest(x, y, Player)

if !p
	exit

with p {
	var _bwp = bwep,
		type = 0
	
	if race == 13 {
		bwep = 7
	}
	
	var a = wep_type[wep],
		b = wep_type[bwep]
	
	if ammo[a] >= typ_amax[a] or ammo[b] >= typ_amax[b] {
		type = choose(1, 2, 3, 4, 5)
	}
	else if bwep != 0 {
		type = choose(a, b)
	}
	else type = a

	if race == 13 {
		bwep = _bwp
	}

	if type == 0 {
		type = choose(1, 2, 3, 4, 5)
	}
	
	var extra = 0

	//RUSH CROWN
	if crown_current == crwn_haste
		extra = 1

	ammo[type] = max(typ_ammo[type] + extra, typ_amax[type])
	
	var dir = instance_create(x, y, PopupText)
	
	dir.mytext = "+" + string(typ_ammo[type] + extra) + " " + loc(typ_name[type])
	
	if ammo[type] >= typ_amax[type] {
		dir.mytext = loc_sfmt("MAX %", loc(typ_name[type]))
	}
}

instance_create(x, y, SmallChestPickup)

if GameCont.coopultra == 1 {
	with Player {
		if id != p {
			other.x = x
			other.y = y
			
			with other {
				event_perform(ev_collision, Player)
			}
		}
	}
}

snd_play(sndAmmoPickup)

instance_destroy()