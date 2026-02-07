event_inherited()
ammo = 10
time = 1

alarm[0] = 30

if (scr_skill_get(mut_laser_brain)) {
	image_xscale *= 1.2
	ammo *= 2
}