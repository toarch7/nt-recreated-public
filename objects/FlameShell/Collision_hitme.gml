if other.team != team and other.hp > 0 {
    with other {
        hp -= 2 + other.bonus
        sprite_index = spr_hurt
        image_index = 0

        motion_addm(other.direction, 3)

        last_hit = other.hit_id
        inframes = 5
    }

    snd_play_hit(other.snd_hurt, 0.2)

    with instance_create(x, y, BulletHit)
    sprite_index = sprBullet2Disappear

    instance_destroy()
}