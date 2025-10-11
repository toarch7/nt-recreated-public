var _dir = random_angle

repeat 8 {
	with instance_create(x, y, AcidStreak) {
        motion_add(_dir, 8)
        image_angle = direction
    }
	
	_dir += 45
}

instance_create(x, y, Exploder)

snd_play(choose(sndFrogEggOpen1, sndFrogEggOpen2))

instance_destroy()