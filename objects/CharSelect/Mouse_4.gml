if instance_exists(DailyList) or net_event(ev_mouse, ev_left_press) exit

if UberCont.cgot[num] or UberCont.weekly_run {
    if !selected {
        var inst = playerinstance_get(),
			race = num
		
        with CharSelect {
            selected = id == other.id
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
		
        if num >= 13 && num <= 15 && net_isme() {
            with Menu {
                loadout = 0
            }
        }
		
        with Menu {
			if !net_isme() {
				ports_x[global.index] = 150
			}
			else port_x = 150
		}
		
        snd_play(snd_slct)
    }
	else scrRunStart()
}

if !UberCont.cgot[num] {
    with Menu {
        alarm[11] = 90
        hint = "locked#" + race_lock[other.num]
    }
}