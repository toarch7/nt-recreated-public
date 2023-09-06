if lockstep_stop
	exit

if other.team != team {
    hitted = 1

    with other {
        if !inframes {
            snd_play_hit(snd_hurt, 0.2)

            hp -= other.dmg * 2

            sprite_index = spr_hurt
            image_index = 0

            motion_add(other.direction, 8)

            instance_create(x, y, MeatExplosion)

            snd_play_hit(sndExplosion, 0.2)

            BackCont.shake += 5

            inframes = 5
        }
    }
}