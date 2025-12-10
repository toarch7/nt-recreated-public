image_index = 1
image_speed = 0

repeat (3) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, random(2))
}

for(var _iteration = 0; _iteration < 100; ++_iteration) {
	xprevious = x
    yprevious = y
	
    x += lengthdir_x(4, direction)
    y += lengthdir_y(4, direction)
    
	var _hit = instance_place(x, y, hitme)
    
	if place_meeting(x, y, Wall) || (instance_exists(_hit) && _hit.team != team) {
        x = xprevious
        y = yprevious
        break
    }
	else if !irandom(2) {
        with instance_create(x, y, Smoke) {
            motion_add(random_angle, random(2))
        }
    }
	
	if bonus && _iteration > 8 {
		event_perform(ev_alarm, 2)
	}
}