if lockstep_stop
	exit

if other.team != team && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team and other.hp > 0 {
    if other.object_index = Player {
        if !(skill_get(5) and other.roll = 1) {
            with instance_create(x, y, BulletHit)
            sprite_index = sprAllyBulletHit
            instance_destroy()
        }
        if skill_get(5) and other.roll = 1 {
            if team != other.team {
                team = other.team
                direction = point_direction(other.x, other.y, x, y)
                if typ != 1 instance_destroy()
            }
        } else {
            if other.sprite_index != other.spr_hurt {
                with other {
                    sprite_index = spr_hurt
                    image_index = 0
                    hp -= other.dmg
                    snd_play_hit(snd_hurt, .2)
                    motion_add(point_direction(other.x, other.y, x, y), 4)
                    sleep(40)
                }
            }
        }
    } else {
        instance_destroy()

        with other {
            snd_play_hit(snd_hurt, .2)
            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 4)
        }
        with instance_create(x, y, BulletHit)
        sprite_index = sprEnemyBulletHit
    }
}