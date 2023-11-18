event_inherited()

index = get_nearest_touch(rad)

var player = noone,
	pinst = player_get(),
	_index = global.index

with Player {
	if index == _index
		player = id
}

var forever = KeyCont.activeforever[_index],
	can_forever = self.can_forever(player)
	handled = false

KeyCont.hold_spec[_index] = 0
KeyCont.press_spec[_index] = 0
KeyCont.release_spec[_index] = 0

if !player
	exit

var rogue_moment = player.race == 12 && player_pref(pinst, "rogue")

if !is_mobile() {
	rogue_moment = false
	can_forever = false
}

if index != -1 or (do_thing == 1) {
    if device_mouse_check_button_pressed(index, mb_left) or (do_thing == 1) {
		if can_forever or forever {
			forever ^= 1
			
            KeyCont.activeforever[_index] = forever
			
			if player.race == 12 && forever
				KeyCont.press_spec[_index] = true
			
			if !forever
				exit
        }
		else if forever {
			KeyCont.activeforever[_index] = false
			forever = false
		}
    }
}

if forever {
    if player.race == 3
        KeyCont.hold_spec[_index] = true
	
    if player.race == 4
        KeyCont.press_spec[_index] = true
	
    if player.race == 7
        KeyCont.hold_spec[_index] = KeyCont.hold_fire[_index]
	
    if player.race == 11 && KeyCont.hold_fire[_index]
        KeyCont.hold_spec[_index] = true
	
    if player.race == 12
        KeyCont.hold_spec[_index] = true
	
	with Player {
		if index != _index
			continue
		
		if (race == 14 && player_pref(pinst, "skeleton"))
		or (race == 6  && player_pref(pinst, "yv") && scrYVCanPop(wep)) {
			KeyCont.press_spec[index] = KeyCont.press_fire[index]
				
			KeyCont.hold_fire[index] = false
			KeyCont.press_fire[index] = false
		}
		else if race == 11 && !player_pref(pinst, "horror") {
			KeyCont.press_fire[index] = false
			KeyCont.hold_fire[index] = false
		}
	}
}
else if (!rogue_moment && !can_forever && (is_mobile() or !(player.race == 7 && player_pref(pinst, "steroids")))) {
    KeyCont.hold_spec[_index] = (do_thing == 2) or (index != -1 && device_mouse_check_button(index, mb_left))
    KeyCont.press_spec[_index] = (do_thing == 1) or (index != -1 && device_mouse_check_button_pressed(index, mb_left))
    KeyCont.release_spec[_index] = (do_thing == -1) or (index != -1 && device_mouse_check_button_released(index, mb_left))
}

if rogue_moment {
	if rogue_hide > 0
		rogue_hide --
}

if rogue_touch != -1 && !device_mouse_check_button(rogue_touch, mb_left) {
	KeyCont.activeforever[global.index] = false
	rogue_touch = -1
}

if do_thing {
    do_thing = 2
}
else do_thing = 0
