walk = 0
flame = sprThroneFlameIdle

for (var i = 0; i < ds_list_size(UPDATE_WALLS); i++) {
    var obj = UPDATE_WALLS[| i]

    with obj {
        if place_meeting(x, y, other) {
            instance_destroy()
            instance_create(x, y, FloorExplo)
        }
    }
}

alarm[1] = 130

if hp <= max_hp * 0.4 {
    alarm[1] = 70
}

scrTarget()

if instance_exists(target) && target > 0 {
    if (point_distance(x, y, target.x, target.y) > 290) || (target.y < y + 48) || introwalk == 0 {
        introwalk = 1
        walkdir = point_direction(xstart, y, xstart, target.y)
        walk = 40
        alarm[1] = 40
    } else {
        if (target.y < y + 48) || (target.x < x - 140) || (target.x > x + 140) {
            with instance_nearest(x, y, ThroneStatue) {
                instance_destroy()
            }

            alarm[1] /= 4
            mode = 1
        }

        if mode == 0 {
            if (target.x < x + 32) && (target.x > x - 32) && (random(3) < 2 && instance_exists(Player)) {
                with instance_create(x, y, NothingBeam) {
                    creator = other.id
                    team = other.team
                }

                flame = sprThroneFlameBig
            } else if (hp <= max_hp * 0.4) && instance_exists(Player) {
                alarm[1] = 20
                addangle = choose(0, - 10, 10, 20, - 20, 30, - 30)
                ammo = 3 + GameCont.loops
                alarm[2] = 5
            } else if instance_exists(Player) {
                alarm[1] = 60
                addangle = choose(0, - 10, 10, 20, - 20)
                ammo = (8 + GameCont.loops)
                alarm[2] = 5
            }
        }
    }

    if mode == 1 {
        if instance_exists(Player) {
            with instance_create(x - 70, y + 10, BigGuardianBullet) {
                hit_id = other.hit_id
                motion_add(point_direction(x, y, other.target.x, other.target.y) + random(50) - 25, 7 + random(1))
                image_xscale = other.right
                team = other.team
            }

            with instance_create(x + 70, y + 10, BigGuardianBullet) {
                hit_id = other.hit_id
                motion_add(point_direction(x, y, other.target.x, other.target.y) + random(50) - 25, 7 + random(1))
                image_xscale = other.right
                team = other.team
            }
        }
    }
}

mode = choose(mode, mode, 0, 0, 1)

if random(dmg) > 150 {
    mode = choose(mode, 1)
}

if instance_exists(target) {
    if target.y < y {
        mode = 1
    }
}