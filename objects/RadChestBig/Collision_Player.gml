if lockstep_stop
	exit

hp = 0

if GameCont.crown == 6 {
    with other {
        hp -= 1
        sprite_index = spr_hurt
        image_index = 0
        snd_play_hit(snd_hurt, .2)
        last_hit = sprCrown6Idle

        repeat(16) {
            with instance_create(x, y, Rad)
            motion_add(random_angle, 2 + random(4))
        }
    }
}

snd_play(sndAmmoPickup)

GameCont.noradch = 0