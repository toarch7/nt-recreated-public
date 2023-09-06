if lockstep_stop
	exit

if mouse_x > x and mouse_x < x + 32 and mouse_y > y and mouse_y < y + 32 and image_index != crownmax + 1 and mouse_check_button_pressed(mb_left) and image_speed = 0 {
    Menu.crown = num
}