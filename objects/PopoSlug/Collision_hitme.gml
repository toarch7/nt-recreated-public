if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team and other.hp > 0 {
    instance_destroy()
    with other {
        hp -= 5
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 9)
    }
    snd_play_hit(other.snd_hurt, .2)
    with instance_create(x, y, BulletHit)
    sprite_index = sprBullet2Disappear
}