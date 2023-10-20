if hp <= 0 {
	instance_create(x, y, RadMaggotExplosion)
}

repeat 4 {
	with instance_create(x, y, Smoke)
	motion_add(random_angle, random(3))
}

instance_create(x, y, ExploderExplo)
snd_play(sndEXPChest)

event_inherited()