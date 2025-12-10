event_inherited()

typ = 2
damage = 8

with (instance_create(x, y, PortalClear)) {
	image_xscale *= 0.5
	image_yscale *= 0.5
}

if (scr_skill_get(mut_laser_brain)) alarm[0] = 1
alarm[1] = 180