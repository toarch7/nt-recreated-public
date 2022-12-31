if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team and other.hp > 0 {
    if other.object_index = Player {
        if other.sprite_index != other.spr_hurt {
            with other {
                sprite_index = spr_hurt
                image_index = 0
                hp -= other.dmg
                snd_play_hit(snd_hurt, .2)
                motion_add(point_direction(other.x, other.y, x, y), 2)
                sleep(40)
            }
        }
    } else {

        with other {
            snd_play_hit(snd_hurt, .2)
            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 4)
        }
    }

    instance_destroy()
    with instance_create(x, y, BulletHit)
    sprite_index = sprEnemyBulletHit
}