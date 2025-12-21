event_inherited()

with YungVenuzCouch {
	repeat (8) {
		with (scrFX(x, y, Feather, random_angle, random_range(2, 3))) {
			sprite_index = sprMoney
			vspeed *= 0.7
		}
	}
	
	instance_destroy(id, false)
	instance_create(x, y, YVBoss)
	instance_destroy(VenuzCouch)
}

with YungCuz {
	alarm[1] = 1
    snd_play(sndCuzCryNew)
    spr_idle = sprCuzCry
    spr_to = sprCuzCry
    spr_from = sprCuzCry
    spr_heya = sprCuzCry
	sprite_index = spr_idle
}