pos++letterbox = 0
doin = 0

if pos == 1 {
    ang = random(360)

    repeat(20) {
        with instance_create(x, y, Dust)
        motion_add(other.ang, 6 - random(1))

        ang += 18
    }

    instance_create(x, y, WeaponChest)
}

if pos == 4 {
    alarm[0] = 45
} else if global.pc_build or UberCont.opt_gamepad {
    alarm[0] = 45
}

if pos > 4 && !instance_exists(Portal) {
    save_set_val("game", "tutorial", 0)
    instance_create(10016, 10016, Portal)
}