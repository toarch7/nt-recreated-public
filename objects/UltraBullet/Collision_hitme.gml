if lockstep_stop
	exit

if other.team != team && other.hp > 0 {
    with other {
        hp -= 18
        sprite_index = spr_hurt
        image_index = 0

        motion_addm(other.direction, 8)

        inframes = 5

        last_hit = other.hit_id
    }

    snd_play_hit(other.snd_hurt, 0.2)
    instance_create(x, y, BulletHit)

    //RECYCLE GLAND
    if instance_exists(Player) {
        if skill_get(16) && random(3) < 2 {
            with Player {
                ammo[1] += 2

                if ammo[1] > typ_amax[1] {
                    ammo[1] = typ_amax[1]
                }
            }

            with instance_create(x, y, Shell) {
                image_angle = random_angle
                motion_add(image_angle, 1 + random(1))
            }

            snd_play(sndRecycleGlands)
        }
    }

    instance_destroy()
}