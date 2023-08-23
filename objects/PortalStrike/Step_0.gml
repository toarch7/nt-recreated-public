if !visible
	exit

if instance_exists(creator) {
	var index = creator.index
    
    if is_keyboard(index) {
        direction = point_direction(x, y, mouse_x, mouse_y)
    }
	
	else if is_gamepad(index) {
		var h = gamepad_axis_value(0, gp_axisrh),
			v = gamepad_axis_value(0, gp_axisrv)
		
        direction = point_direction(x, y, x + h, y + v)
    }
	
	else if ButtonActive.rogue_bombing {
        if device_mouse_check_button(touch, mb_left) {
            direction = point_direction(x, y, device_mouse_x(touch), device_mouse_y(touch))
        }
		else {
            touch = -1
        }
    }

    if instance_exists(ButtonActive) && is_mobile(index) && ButtonActive.rogue_bombing {
        if touch == -1 {
            ButtonActive.rogue_bombing = 0
            event_user(0)
        }
    }
	else if !is_mobile(index) && !KeyCont.hold_spec[index] {
		event_user(0)
    }
}
else event_user(0)

image_angle = direction