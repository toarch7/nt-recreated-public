if lockstep_stop
	exit

if (setup) {
	if (instance_is(creator, Player) && creator.bskin == SkinLetter.C) {
		sprite_index = buttgot ? sprRogueStrikeCTB : sprRogueStrikeC
	}
	
	setup = false
}

if (!visible) exit

if (!instance_exists(creator)) {
	event_user(0)
	exit
}

var _index = creator.index,
	
	_distance = KeyCont.dis_fire[_index],
	_direction = KeyCont.dir_fire[_index],
	
	_pinst = scr_playerinstance_find(_index),
	
	_mx = x + ldrx(_distance, _direction),
	_my = y + ldry(_distance, _direction)

if is_touch(_index) && scr_player_pref(_pinst, "rogue") {
	if (!KeyCont.activeforever[_index]) {
		KeyCont.activeforever[_index] = false
		event_user(0)
    }
	else {
		// fixme: multitouch portal strike swipes aren't supported in current multiplayer
        direction = point_direction(x, y,
			device_mouse_x(touch), device_mouse_y(touch))
	}
}
else {
	if is_keyboard(_index) {
		_mx = mouse_x
		_my = mouse_y
	}
	
	direction = is_keyboard(_index) ? point_direction(x, y, _mx, _my) : _direction
	
	if (!KeyCont.hold_spec[_index]) {
		KeyCont.activeforever[_index] = false
		event_user(0)
	}
}

image_angle = direction