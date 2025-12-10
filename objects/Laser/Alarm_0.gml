var _dir = 0, _step = 2

do {
    x += ldrx(_step, image_angle)
	y += ldry(_step, image_angle)
	_dir += 1
}
until (place_meeting(x, y, hitme) && _dir > 16) || place_meeting(x, y, Wall) || _dir > 160

alarm[0] = 2

image_xscale = point_distance(x, y, xstart, ystart) / 2
instance_create(x, y, Smoke)