with MusCont {
	if (alarm[0] == -1 || snd_is_playing(musThemeB)) {
		break
	}
	snd_stop(song)
    event_perform(ev_alarm, 0)
    alarm[0] = -1
}

dix = 32
diy = 32

background_set_colour(scrAreaGetBackroundColor(area_campfire))

repeat 3 {
    repeat 4 {
		mody = choose(32, 0, -32)
		
		instance_create(x + dix + mody, y + diy + mody, Floor)
		instance_create(x + dix + mody + 32, y + diy + mody, Floor)
		instance_create(x + dix + mody - 32, y + diy + mody, Floor)
		
		instance_create(x + dix + mody, y + diy + mody + 32, Floor)
		instance_create(x + dix + mody + 32, y + diy + mody + 32, Floor)
		instance_create(x + dix + mody - 32, y + diy + mody + 32, Floor)
		
		instance_create(x + dix + mody, y + diy + mody - 32, Floor)
		instance_create(x + dix + mody + 32, y + diy + mody - 32, Floor)
		instance_create(x + dix + mody - 32, y + diy + mody - 32, Floor)
		
        dix += 32
    }

    dix = 0
    diy += 32
}

repeat 4 {
    instance_create(choose(0, 32, 64, 96, 128), choose(0, 32, 64, 96, 128), FloorMaker)
}

alarm[1] = 2

instance_create(0, 0, BackCont)
instance_create(0, 0, TopCont)
instance_create(0, 0, Menu)