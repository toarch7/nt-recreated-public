if lockstep_stop
	exit

if image_index < 1 {
	image_index += random(0.04)
}
else image_index += 0.4

if (!place_meeting(x, y, Wall)) {
	image_angle += rotspeed * speed * 2
}

if current_frame_active && curse && random(6) < 1 {
    instance_create(x + orandom(4), y + orandom(4), Curse)
}

if speed > 0 {
    if (alarm[1] > 30) alarm[1] = 30
}
else if mask_index == mskPlasma {
    mask_index = mskWepPickup
	friction = 0.4
}

if (cuz_fun) {
	if (
		slowreturn && autopick && instance_exists(creator)
		&& (slowreturn == 2 || speed == 0)
	) {
		motion_add(point_direction(x, y, creator.x, creator.y), 1 + friction + speed * 0.1)
		if (abs(rotspeed) < 10) rotspeed += sign(rotspeed) * 0.2
		if (speed > 16) speed = 16
		slowreturn = 2
	}
	
	if (autopick && current_frame_active && random(9) < (slowreturn ? (speed * 2) : 1)) {
		with (instance_create(
			bbox_center_x + orandom(2),
			bbox_center_y + orandom(2),
			WepSwap)
		) {
			if (instance_exists(SubTopCont)) {
				depth = SubTopCont.depth
			}
			x += ldrx(4, other.image_angle)
			y += ldry(4, other.image_angle)
			image_xscale = random_range(0.6, 1)
			image_yscale = image_xscale
		}
	}
}