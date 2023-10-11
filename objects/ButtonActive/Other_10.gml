event_inherited()

index = get_nearest_touch(rad)

var player = noone,
	pinst = playerinstance_get(),
	_index = global.index

with Player {
	if index == _index
		player = id
}

var forever = KeyCont.activeforever[_index]

KeyCont.hold_spec[_index] = 0
KeyCont.press_spec[_index] = 0
KeyCont.release_spec[_index] = 0

if !player
	exit

if index != -1 or (do_thing == 1) {
    if device_mouse_check_button_pressed(index, mb_left) or (do_thing == 1) {
		if (player.race == 3 && pinst.pref("eyes"))
		or (player.race == 4 && pinst.pref("melting"))
		or (player.race == 6 && pinst.pref("yv"))
		or (player.race == 14 && pinst.pref("skeleton"))
		or (player.race == 7 && pinst.pref("steroids"))
		or (player.race == 12 && !pinst.pref("rogue"))
		or (player.race == 11) {
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
		
		if (race == 14 && pinst.pref("skeleton"))
		or (race == 6  && pinst.pref("yv") && scrYVCanPop(wep)) {
			KeyCont.press_spec[index] = KeyCont.press_fire[index]
				
			KeyCont.hold_fire[index] = false
			KeyCont.press_fire[index] = false
		}
		else if race == 11 && !pinst.pref("horror") {
			KeyCont.press_fire[index] = false
			KeyCont.hold_fire[index] = false
		}
	}
}
else if (is_mobile() or !(player.race == 7 && pinst.pref("steroids"))) {
    KeyCont.hold_spec[_index] = (do_thing == 2) or (index != -1 && device_mouse_check_button(index, mb_left))
    KeyCont.press_spec[_index] = (do_thing == 1) or (index != -1 && device_mouse_check_button_pressed(index, mb_left))
    KeyCont.release_spec[_index] = (do_thing == -1) or (index != -1 && device_mouse_check_button_released(index, mb_left))
}

print(rogue_touch, device_mouse_check_button(rogue_touch, mb_left))
if rogue_touch != -1 && !device_mouse_check_button(rogue_touch, mb_left) {
	KeyCont.activeforever[global.index] = false
	rogue_touch = -1
}

if do_thing {
    do_thing = 2
}
else do_thing = 0
