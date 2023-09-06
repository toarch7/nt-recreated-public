if lockstep_stop
	exit

if other.team != team and other.hp > 0 {
    with other {
        hp -= 9

        sprite_index = spr_hurt
        image_index = 0

        other.last_hit = other.hit_id

        motion_add(other.direction, 3)
    }

    snd_play_hit(other.snd_hurt, 0.2)

    with instance_create(x, y, BulletHit)
    sprite_index = sprUltraShellDisappear

    instance_destroy()
}