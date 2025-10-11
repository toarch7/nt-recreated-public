/// @description Draw loadout

var _w = gui_w,
	_h = gui_h

// will draw the race name and characters' skills
scrMenuDrawPlayersOrdered(0, 0, scrCampfireMenuDrawCharText)

//
if player_count == 1 {
	scrMenuDrawLoadout(my_player)
}

var _loadout_target_frame = loadout_open ? (sprite_get_number(sprLoadoutOpen) - 1) : 0
loadout_frame = approach(loadout_frame, _loadout_target_frame, timescale)

// update loadout & charskin animations
for(var i = 0; i < INPUT_MAX_PLAYERS; ++ i) {
	if textappear[i] != 0 {
		textappear[i] = approach(textappear[i], 0, timescale)
	}
	
	if portrait_offsets[i] != 0 {
		var _amount = clamp(portrait_offsets[i], 0, 180)
		
		if _amount == 2 {
			portrait_offsets[i] = 0
		}
		else if _amount == 90 {
			portrait_offsets[i] = 2
		}
		else portrait_offsets[i] = 90
	}
}

if splatindex < 3 {
	splatindex += 0.4 * timescale
	if splatindex > 3 {
		splatindex = 3
	}
}