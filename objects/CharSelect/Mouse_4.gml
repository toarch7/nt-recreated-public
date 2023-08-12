if !UberCont.cgot[num] && !UberCont.weekly_run {
	with Menu {
        hint = race_lock[other.num]
        alarm[11] = 90
    }
	
	snd_play(sndClickBack)
	
	exit
}

if instance_exists(DailyList) or net_event(ev_mouse, ev_left_press)
	exit

var is_me = net_isme(),
	inst = playerinstance_get(),
	race = num

if instance_exists(CoopController) {
	inst = struct_clone(inst)
}

if inst.race != race {
    if is_me {
	    with CharSelect {
	        selected = 0
		}
		
		selected = 1
	}
	
    inst.race = race
    inst.skin = save_get_val("cskin", string(race), 0)
	
    if !UberCont.daily_run {
        inst.cwep = save_get_val("cswep", string(race), 0) ? UberCont.cwep[race] : UberCont.race_swep[race]
    }
	else if !UberCont.weekly_run {
        inst.cwep = race_swep[race]
    }
	
    with GoButton {
        image_speed = 0.4
        image_index = 0
    }
	
    snd_slct = asset_get_index("sndMutant" + string(race) + "Slct")
	
    if num == 13 {
        snd_slct = sndBigDogIntro
    }
	
	if instance_exists(CoopController) {
		if is_me {
			net_add_data("other", "playerinstance", inst)
		}
	}
	else {
		with Menu {
			port_x = 150
			
			if race >= 13 && race <= 15
				loadout = 0
			
			appear = 2
		}
	}
	
    snd_play(snd_slct)
}
else scrRunStart()
