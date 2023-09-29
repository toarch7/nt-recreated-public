var i = get_nearest_touch(rad)

if wep_spr == mskNone {
	var player = noone
	
	with Player {
		if index == global.index {
			player = id; break
		}
	}
	
	if player != noone
		scrSwapstickUpdateSprite(player)
}

if i != -1 && !active {
	KeyCont.press_swap[global.index] = device_mouse_check_button_pressed(i, mb_left)
	
	with SwapstickAttack {
		if active
			KeyCont.release_swap[global.index] = true
		
		active = false
		
		if id != other.id
			index = -1
	}
	
	active = true
}

if active {
	event_inherited()
	
	if !KeyCont.hold_fire[global.index]
		KeyCont.hold_swap[global.index] = true
}
