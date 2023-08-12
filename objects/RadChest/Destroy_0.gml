if !hp {
	with instance_create(x, y, Corpse) {
		mask_index = other.mask_index
		sprite_index = other.spr_dead
		size = other.size
	}
	
	repeat raddrop {
		with instance_create(x, y, Rad)
			motion_add(random(360), random(5))
	}

	GameCont.noradch = 0
}

repeat 4 {
	with instance_create(x, y, Smoke)
		motion_add(random(360), random(3))
}

instance_create(x, y, ExploderExplo)

if !instance_exists(GenCont)
	snd_play(sndEXPChest)
