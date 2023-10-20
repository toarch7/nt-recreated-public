if (sprite_index == sprAllyAppear) {
    spr_idle = sprAllyIdle
    sprite_index = spr_idle
}

if (instance_number(Ally) > UberCont.ctot_uniq[10]) UberCont.ctot_uniq[10] = instance_number(Ally)
alarm[1] = (10 + random(5))
if instance_exists(enemy) target = instance_nearest(x, y, enemy)
if ((target >= Player) && instance_exists(target)) {
    if ((collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0) && (point_distance(x, y, target.x, target.y) < 240)) {
        if ((random(10) < 9) && instance_exists(enemy)) {
            snd_play(sndEnemyFire)
            gunangle = target_direction
            wkick = 4
            with(instance_create(x, y, AllyBullet)) {
                motion_add(((other.gunangle + random(20)) - 10), 6)
                image_angle = direction
                team = other.team
            }
            if (skill_get(5)) alarm[1] = 5
            else alarm[1] = 8
        } else {
            direction = ((target_direction + random(180)) - 90)
            speed = 0.5
            if (instance_exists(creator) && (random(4) < 3)) {
                motion_add(point_direction(x, y, (view_xview + (view_width / 2)), (view_yview + (view_height / 2))), 0.8)
                motion_add(point_direction(x, y, creator.x, creator.y), 1)
            }
            walk = (10 + random(10))
            gunangle = target_direction
        }
        if (target.x < x) right = -1
        else if (target.x > x) right = 1
    } else if (random(4) < 3) {
        motion_add(random_angle, 0.4)
        if instance_exists(creator) {
            motion_add(point_direction(x, y, (view_xview + (view_width / 2)), (view_yview + (view_height / 2))), 0.8)
            motion_add(point_direction(x, y, creator.x, creator.y), 1)
        }
        walk = (10 + random(10))
        alarm[1] = (walk + 2)
        gunangle = direction
        if (hspeed > 0) right = 1
        else if (hspeed < 0) right = -1
    }
} else if (random(10) < 1) {
    motion_add(random_angle, 0.4)
    walk = (20 + random(10))
    alarm[1] = (walk + 5)
    gunangle = direction
    if (hspeed > 0) right = 1
    else if (hspeed < 0) right = -1
}