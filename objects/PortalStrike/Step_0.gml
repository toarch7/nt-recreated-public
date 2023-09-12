if lockstep_stop
	exit

if !visible
	exit

if instance_exists(creator) {
	var index = creator.index,
		
		inst = playerinstance_get(index),
		
		cx = creator.x + ldrx(view_width * KeyCont.dis_fire[index], KeyCont.dir_fire[index]),
		cy = creator.y + ldry(view_height * KeyCont.dis_fire[index], KeyCont.dir_fire[index])
	
	if inst.pref("rogue") && KeyCont.activeforever[index] {		
        if device_mouse_check_button(touch, mb_left) {
            direction = point_direction(x, y, device_mouse_x(touch), device_mouse_y(touch))
        }
		else touch = -1
    }
	else direction = point_direction(x, y, cx, cy)
	
	if is_mobile(index) && inst.pref("rogue") {
		
		if KeyCont.activeforever[index] && touch == -1 {
		    KeyCont.activeforever[index] = 0
			event_user(0)
		}
		
	}
	else if !KeyCont.hold_spec[index]
		event_user(0)
}
else event_user(0)

image_angle = direction