if lockstep_stop
	exit

if !visible
	exit

if instance_exists(creator) {
	var index = creator.index,
		
		inst = playerinstance_get(index),
		
		cx = creator.x + ldrx(128 * KeyCont.dis_fire[index], KeyCont.dir_fire[index]),
		cy = creator.y + ldry(128 * KeyCont.dis_fire[index], KeyCont.dir_fire[index])
	
	if inst.pref("rogue") && ButtonActive.rogue_bombing {
        if device_mouse_check_button(touch, mb_left) {
            direction = point_direction(x, y, device_mouse_x(touch), device_mouse_y(touch))
        }
		else {
            touch = -1
        }
    }
	else direction = point_direction(x, y, cx, cy)
	
	if is_mobile(index) {
		if inst.pref("rogue") {
			if ButtonActive.rogue_bombing && touch == -1 {
		        with ButtonActive
					rogue_bombing = 0
				
				event_user(0)
			}
		}
		else if !KeyCont.activeforever[index]
			event_user(0)
	}
	else if !KeyCont.hold_spec[index]
		event_user(0)
}
else event_user(0)

image_angle = direction