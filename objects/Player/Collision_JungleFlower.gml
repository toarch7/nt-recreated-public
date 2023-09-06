if lockstep_stop
	exit

if KeyCont.press_pick[p] {
    dir = random(360)
    repeat 2 + random(3) {
        with instance_create(x, y, BloodStreak) {
            motion_add(other.dir, 5)
            image_angle = direction
        }

        dir += 60 + random(30)
    }

    hp--inframes = 5
    sprite_index = spr_hurt
    snd_play_hit(snd_hurt, 0.2)
    last_hit = sprJungleFlowerIdle
    other.feed++
}