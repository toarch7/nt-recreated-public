if instance_exists(GenCont) or hp > 0
	exit

repeat 4 {
	with instance_create(x, y, Smoke)
		motion_add(random_angle, random(3))
}

instance_create(x, y, ExploderExplo)

if !instance_exists(GenCont)
	snd_play(sndEXPChest)

UberCont.noradch = 0

event_inherited()