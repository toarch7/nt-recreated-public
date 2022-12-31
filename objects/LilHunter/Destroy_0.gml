if hp > 0 exit

scrDrop(200, 0)

with MusCont {
    alarm[1] = 1
}

with instance_create(x, y, Explosion) {
    hit_id = other.hit_id
}

var firang = random(360)

repeat 80 {
    firang += 4.5
    with instance_create(x, y, TrapFire) {
        hit_id = other.spr_idle
        sprite_index = sprFireLilHunter
        motion_add(firang, 2 + random(0.2))
        move_contact_solid(direction, 12)
        image_angle = direction
        team = other.team
        hit_id = other.spr_idle
    }
}

instance_create(x, y, PortalClear)

with instance_create(x, y, LilHunterDie) {
    hit_id = sprLilHunterHurt
    team = other.team
}

GameCont.kills += 1

if instance_exists(Player) {
    var p = noone
    with Player
    if is_me {
        p = id
    }

    UberCont.ctot_kill[p.race] += 1

    with Player {
        if race == 4 {
            other.raddrop += 1
        }
    }
}

snd_play(snd_dead)

do {
    if raddrop > 15 {
        with instance_create(x, y, BigRad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(other.raddrop / 2) + 2)

            repeat speed {
                speed *= 0.9
            }
        }

        raddrop -= 10
    }
} until raddrop <= 15

repeat raddrop {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(other.raddrop / 2) + 2)

        repeat speed {
            speed *= 0.9
        }
    }
}

scrAchievement(32)