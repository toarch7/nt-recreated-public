move_contact_solid(direction, 16)

repeat 4 {
    with (instance_create(x, y, Smoke)) speed ++
}

sleep(50)

var _dir = 0,
	_xstep = bbox_width,
	_ystep = bbox_height

do {
    _dir ++
	x += lengthdir_x(_xstep, direction)
	y += lengthdir_y(_ystep, direction)
}
until _dir > 100 || place_meeting(x, y, Wall) || place_meeting(x, y, hitme)

alarm[1] = 2