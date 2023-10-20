var i = get_nearest_touch(rad)

KeyCont.hold_fire[global.index] = 0
KeyCont.press_fire[global.index] = 0
KeyCont.release_fire[global.index] = 0

if index == -1
	index = i

if index != -1 {
	KeyCont.hold_fire[global.index] = device_mouse_check_button(i, mb_left)
	KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(i, mb_left)
	KeyCont.release_fire[global.index] = device_mouse_check_button_released(i, mb_left)
}

index = -1

scrControlAutoSnare()