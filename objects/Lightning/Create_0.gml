event_inherited()
hit_id = -1

typ = 0
image_speed = 0.4

if skill_get(17) {
	image_speed = 0.3
}

if GameCont.area == 101 {
    with hitme {
        if !inframes && x > view_xview && x < view_xview + view_width && y > view_yview && y < view_yview + view_height {
            snd_play(snd_hurt)
            hp -= 2
            sprite_index = spr_hurt
            image_index = 0
            inframes = 5
        }
    }

    with Player {
        last_hit = sprLightningDeath
    }

    instance_create(x, y, Smoke)
    instance_destroy()
    exit
}