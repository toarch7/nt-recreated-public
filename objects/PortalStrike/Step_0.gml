if lockstep_stop
	exit

if !visible
	exit

if instance_exists(creator) {
	var index = creator.index,
		
		inst = playerinstance_get(index),
		
		cx = creator.x + ldrx(view_width * KeyCont.dis_fire[index], KeyCont.dir_fire[index]),
		cy = creator.y + ldry(view_height * KeyCont.dis_fire[index], KeyCont.dir_fire[index])
	
	if is_mobile(index) && inst.pref("rogue") {
		if !KeyCont.activeforever[index] {
			event_user(0)
			KeyCont.activeforever[index] = false
        }
		else {
            direction = point_direction(x, y, device_mouse_x(touch), device_mouse_y(touch))
		}
	}
	else {
		direction = point_direction(x, y, cx, cy)
		
		if !KeyCont.hold_spec[index] {
			KeyCont.activeforever[index] = 0
			event_user(0)
		}
	}
}
else event_user(0)

image_angle = direction