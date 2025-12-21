if lockstep_stop
	exit

var _race = race

if !can {
	if (is_touch()) with (Menu) {
        unlock_hint = scrRaceGetUnlockDescription(_race)
		unlock_hint_pop = 2
        alarm[11] = 90
    }
	
	snd_play(sndNoSelect)
	exit
}

if instance_exists(DailyList) || scr_network_handle_event(event_type, event_number)
	exit

var _is_me = scr_is_authority(),
	_pinst = scr_playerinstance_find()

with (GoButton) if (!visible) {
	visible = true
	addy = 1
}

if _pinst.race != _race {
    if _is_me {
	    with CharSelect {
	        selected = false
		}
		
		selected = true
	}
	
	scrCampfireMenuSelectionChange(_pinst.index, _race)
	
	if instance_exists(CoopController) && _is_me {
		scr_network_attach_event_data("other", "my_player", _pinst)
	}
	
    snd_play(scr_race_get_sound(_race, "Slct"))
}
else {
	scrRunStart()
}
