if !instance_exists(creator) {
    instance_destroy()
    exit
}

with creator {
    if race == 13 {
        spr_idle = sprScrapBossFire
        spr_walk = sprScrapBossFire
        spr_hurt = sprScrapBossHurtSpin
        sprite_index = spr_idle
    }

    other.x = x
    other.y = y
}

repeat 6 {
    with instance_create(x + lengthdir_x(24, direction), y + lengthdir_y(16, direction), AllyBullet) {
        creator = other.id
        motion_add(other.direction, 2)
        image_angle = direction
        team = other.team
    }

    direction += 360 / 6
}

if GameCont.ultra == 1 {
    repeat 6 {
        with instance_create(x + lengthdir_x(24, - direction), y + lengthdir_y(16, - direction), AllyBullet) {
            creator = other.id
            motion_add(-other.direction, 2)
            image_angle = direction
            team = other.team
        }

        direction += 360 / 6
    }
}

direction += 4 * turn

ammo--

if !ammo {
    with creator
    if race == 13 {
        spr_idle = sprScrapBossIdle
        spr_walk = sprScrapBossWalk
        spr_hurt = sprScrapBossHurt
    }

    instance_destroy()
}

alarm[0] = 5