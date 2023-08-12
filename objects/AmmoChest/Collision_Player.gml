if !instance_exists(GenCont) {
	if scrChestOpened()
		exit
	
	var p = instance_nearest(x, y, Player), dir, type
	
	if !p
		exit
	
	var m = p.ammo
	
	if p.race == 7 && p.ultra == 2 {
		for(var i = 1; i <= 5; i ++) {
			type = i
			
			var a = typ_ammo[type]
			
			m[type] += a * 2
			
			if m[type] > typ_amax[type]
				m[type] = typ_amax[type]
			
			dir = instance_create(x, y, PopupText)
			
			dir.mytext = "+" + string(a * 2) + " " + string(loc(typ_name[type]))
			
			if m[type] >= typ_amax[type]
				dir.mytext = loc_sfmt("MAX %", loc(typ_name[type]))
		}
		
		p.ammo = m
		
		instance_destroy()
		
		exit
	}
	
	if wep_type[other.wep] == 0 or m[wep_type[other.wep]] >= typ_amax[wep_type[other.wep]]
		type = irandom(4) + 1
	else
		type = wep_type[other.wep]

	m[type] += typ_ammo[type] * 2
	
	if m[type] > typ_amax[type]
		m[type] = typ_amax[type]

	dir = instance_create(x, y, PopupText)
	
	dir.mytext = "+" + string(typ_ammo[type] * 2) + " " + string(loc(typ_name[type]))
	
	if m[type] = typ_amax[type]
		dir.mytext = loc_sfmt("MAX %", loc(typ_name[type]))
	
	
	
	if GameCont.underwater
		snd_play(sndOasisChest)
	else
		snd_play(sndAmmoChest)
	
	p.ammo = m
	
	instance_destroy()
}

