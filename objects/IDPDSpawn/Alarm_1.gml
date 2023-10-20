instance_create(x, y, PortalClear)

if GameCont.loops - (GameCont.area == 0) >= 3 {
    instance_create(x + orandom(2), y + orandom(2), PopoFreak)
    exit
}

hrd = GameCont.hard - (13 * global.hardmode)

do {
    dir = rng_choose(1, 1, 2, 3)
} until !(dir == 3 && GameCont.popolevel < 3) && !(dir == 2 && GameCont.popolevel < 5)

if !GameCont.loops && instance_exists(LilHunter) dir = 1

var player = instance_nearest(x, y, Player)

if dir == 1 {
    if !elite {
        repeat(2) {
            with instance_create(x + random(4) - 2, y + random(4) - 2, Grunt) {
                if instance_exists(player) {
                    motion_add(point_direction(x, y, player.x, player.y) + random(90) - 45, 4)
                } else motion_add(random_angle, 4)
            }
        }
    } else instance_create(x + random(4) - 2, y + random(4) - 2, EliteGrunt)
}

if dir == 2 {
    if !elite {
        with instance_create(x + random(4) - 2, y + random(4) - 2, Shielder) {
            if instance_exists(player) {
                motion_add(point_direction(x, y, player.x, player.y) + random(90) - 45, 4)
            } else motion_add(random_angle, 4)
        }
    } else instance_create(x + random(4) - 2, y + random(4) - 2, EliteShielder)
}

if dir == 3 {
    if !elite {
        with instance_create(x + random(4) - 2, y + random(4) - 2, Inspector) {
            if instance_exists(player) {
                motion_add(point_direction(x, y, player.x, player.y) + random(90) - 45, 4)
            } else motion_add(random_angle, 4)
        }
    } else instance_create(x + random(4) - 2, y + random(4) - 2, EliteInspector)
}