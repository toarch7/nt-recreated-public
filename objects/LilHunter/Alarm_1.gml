if !hp exit

alarm[1] = (20 + random(6))
scrTarget()
if instance_exists(target) {
    if random(30) < 1 || (point_distance(x, y, target.x, target.y) < 64 && random(3) < 2) || (point_distance(x, y, target.x, target.y) > 160) && (random(16) < 1) {
        image_index = 0
        sprite_index = sprLilHunterLiftStart
        instance_change(LilHunterFly, Player)
        snd_play(sndLilHunterLaunch)
    } else {
        if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
            if random(4) < 3 {
                if point_distance(x, y, target.x, target.y) < 140 {
                    gunangle = target_direction + random(50) - 25
                    snd_play_hit_big(sndLilHunterBouncer, 0.2)
                    wkick = 8
                    addang = -50 - GameCont.loops * 10
                    alarm[1] /= (1 + GameCont.loops * 2)

                    repeat 11 + GameCont.loops {
                        with instance_create(x, y, LHBouncer) {
                            hit_id = other.hit_id
                            motion_add((other.gunangle + other.addang), 3)
                            image_angle = direction
                            team = other.team
                        }

                        addang += 10
                    }

                    direction = point_direction(target.x, target.y, x, y) + (random(20) - 10)
                    speed = 0.4
                    walk = 20
                    gunangle = target_direction
                } else {
                    alarm[1] = 5 + random(6)
                    gunangle = target_direction + random(30) - 15
                    snd_play_hit_big(sndLilHunterSniper, 0.2)
                    wkick = 8
                    repeat 10 + GameCont.loops * 2 {
                        with instance_create(x, y, EnemyBullet1) {
                            hit_id = other.hit_id
                            motion_add(other.gunangle, 7 + random(6))
                            image_angle = direction
                            team = other.team
                        }
                    }
                }
            } else {
                direction = point_direction(target.x, target.y, x, y) + random(20) - 10
                speed = 0.4
                walk = 8 + random(4)
                alarm[1] = walk
                gunangle = target_direction
            }
        } else if random(2) < 1 && spawns > 0 && (hp / max_hp) < spawns / 6 {
            snd_play_hit_big(sndLilHunterSummon, 0.1)
            walk = 0

            repeat 30 {
                with instance_create(x + random(96) - 48, y + random(96) - 48, IDPDPortalCharge) {
                    motion_add(point_direction(x, y, other.x, other.y), 2 + random(1))
                    alarm[0] = point_distance(x, y, other.x, other.y) / speed + 1
                }
            }

            spawns--

            repeat 1 + max(0, (GameCont.loops - 1)) {
                instance_create(x, y, IDPDSpawn)
            }

            alarm[1] += 45
        } else {
            direction = point_direction(target.x, target.y, x, y) + random(20) - 10
            speed = 0.4
            walk = 40 + random(10)
            gunangle = target_direction
            alarm[1] /= 3
        }

        if target.x < x {
            right = -1
        } else if target.x > x {
            right = 1
        }
    }
} else if random(10) < 1 {
    motion_add(random(360), 0.4)
    walk = 8 + random(4)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction

    if hspeed > 0 {
        right = 1
    } else if hspeed < 0 {
        right = -1
    }
}

if instance_exists(target) && walk > 0 {
    motion_add(point_direction(target.x, target.y, x, y), 0.3)
}