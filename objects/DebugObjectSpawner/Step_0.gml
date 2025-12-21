var _object = self.__get_object(keyboard_string)

x = mouse_x
y = mouse_y

if keyboard_check_pressed(vk_tilde) {
	instance_destroy()
}

if mouse_check_button_pressed(mb_right) {
	mouse_clear(mb_right)
	instance_destroy()
}

if keyboard_check(vk_control) && keyboard_check_pressed(vk_backspace) {
	keyboard_string = ""
}

if object_exists(_object) {
	var _grid_size = 0
	
	if (_object == Wall || _object == FloorExplo || _object == TopSmall || _object == Top) {
		_grid_size = 16
	}
	else if (_object == Floor) _grid_size = 32
	
	if (_grid_size != 0) {
		x = (x div _grid_size) * _grid_size
		y = (y div _grid_size) * _grid_size
	}
}

if mouse_check_button(mb_left) {
	if (last_input > current_time) exit
	
	if !press {
		last_input = current_time + 220
		press = true
	}
	else {
		last_input = current_time + 22
	}
	
	snd_play(sndClick, 1.2, 0.3)
	
	if object_exists(_object) {
		if (_object == WepPickup) {
			scrWeaponPickupCreate(x, y, scrDecideWep(0), true)
		}
		else instance_create(x, y, _object)
	}
	else {
		snd_play(sndNoSelect)
		shake = 3
	}
	
	mouse_clear(mb_left)
}
else if press {
	last_input = current_time
	press = false
}