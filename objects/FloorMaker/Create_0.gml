direction = rng_choose(0, 0, 90, 180, 270)

styleb = !rng_random(0, 6 - (GameCont.area == 104 * 4))
if GameCont.area == 100 styleb = 0

goal = 110

if instance_exists(GenCont) {
    goal = GenCont.goal

    if GameCont.area == 7 && GameCont.subarea == 3 {
        direction = 90
        styleb = 0
    }
}

if instance_exists(MenuGen) {
    goal = 90
}

if save_get_val("game", "tutorial", 1) {
    goal = 1
}

instance_create(x, y, Floor)

if GameCont.area == 106 && GameCont.subarea == 3 {
    styleb = 0

    with GenCont {
        alarm[0] = 3
        alarm[2] = 2
    }

    with MenuGen
    alarm[1] = 3

    dix = -5
    diy = 0

    repeat 10 {
        repeat 10 {
            instance_create(x + dix * 32 + 16, y + diy * 32, Floor)
            dix += 1
        }

        dix = -5
        diy -= 1
    }

    instance_create(x - 64 + 16, y - 320 - 32, Floor)
    instance_create(x - 64 + 16, y - 320, Floor)
    instance_create(x + 16, y - 320 - 32, Floor)
    instance_create(x + 16, y - 320, Floor)
    instance_create(x + 16 - 32, y - 320 - 32, Floor)
    instance_create(x + 16 - 32, y - 320, Floor)
    instance_create(x + 16 + 32, y - 320 - 32, Floor)
    instance_create(x + 16 + 32, y - 320, Floor)
    instance_create(x + 16 - 64, y + 32, Floor)
    instance_create(x + 16 - 64, y + 64, Floor)
    instance_create(x + 16, y + 32, Floor)
    instance_create(x + 16, y + 64, Floor)
    instance_create(x + 16 - 32, y + 32, Floor)
    instance_create(x + 16 - 32, y + 64, Floor)
    instance_create(x + 16 + 32, y + 32, Floor)
    instance_create(x + 16 + 32, y + 64, Floor)
    instance_create(x + 16 - 160 - 64, y - 160 - 32, Floor)
    instance_create(x + 16 - 160 - 64, y - 160, Floor)
    instance_create(x + 16 - 160 - 64, y - 160 + 32, Floor)
    instance_create(x + 16 - 160 - 64, y - 160 + 64, Floor)
    instance_create(x + 16 - 160 - 32, y - 160 - 32, Floor)
    instance_create(x + 16 - 160 - 32, y - 160, Floor)
    instance_create(x + 16 - 160 - 32, y - 160 + 32, Floor)
    instance_create(x + 16 - 160 - 32, y - 160 + 64, Floor)
    instance_create(x + 16 + 160, y - 160 - 32, Floor)
    instance_create(x + 16 + 160, y - 160, Floor)
    instance_create(x + 16 + 160, y - 160 + 32, Floor)
    instance_create(x + 16 + 160, y - 160 + 64, Floor)
    instance_create(x + 16 + 160 + 32, y - 160 - 32, Floor)
    instance_create(x + 16 + 160 + 32, y - 160, Floor)
    instance_create(x + 16 + 160 + 32, y - 160 + 32, Floor)
    instance_create(x + 16 + 160 + 32, y - 160 + 64, Floor)
    instance_create(x + 16, y - 160 + 32, FloorMiddle)
    instance_create(x + 16, y - 260, LastIntro)
    instance_create(x + 16, y - 260 - 110, BigTV)
    instance_create(x - 64, y - 160 - 48, Wall)
    instance_create(x - 64, y - 160 + 96, Wall)
    instance_create(x + 80, y - 160 - 48, Wall)
    instance_create(x + 80, y - 160 + 96, Wall)
    instance_create(x - 64 + 8, y - 160 - 48 - 32, PlantPot)
    instance_create(x - 64 + 8, y - 160 + 96 + 32, PlantPot)
    instance_create(x + 80 + 8, y - 160 - 48 - 32, PlantPot)
    instance_create(x + 80 + 8, y - 160 + 96 + 32, PlantPot)
    styleb = 1
    instance_destroy()
    exit
}