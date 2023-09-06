if lockstep_stop
	exit

if mouse_x > x and mouse_x < x + 24 and mouse_y > y and mouse_y < y + 24 and selected = 0 {
    selected = 1
} else selected = 0