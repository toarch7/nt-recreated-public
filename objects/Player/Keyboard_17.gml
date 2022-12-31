///*

//exit

if UberCont.public = 0 {

    if keyboard_check_pressed(ord("H")) {
        hp = 10000
        max_hp = hp
    }

    if keyboard_check_pressed(ord("R")) {
        discard_custom_sprites()
        discard_custom_sounds()
        load_resourcepacks()
    }

    if global.console_active exit

    //CHEATS

    if keyboard_check_pressed(ord("Z")) or mouse_wheel_up() {

        Player.ammo[1] += 200
        Player.ammo[2] += 20
        Player.ammo[3] += 20
        Player.ammo[4] += 20
        Player.ammo[5] += 20
        if wep < maxwep wep += 1
        else wep = 1
    }

    if keyboard_check_pressed(ord("F")) && !GameCont.ultrapoints {

        var n = keyboard_check(vk_shift) ? 12 : 42

        UberCont.chiev_have[n] = 0
        scrAchievement(n)

    }

    if keyboard_check_pressed(ord("X")) or mouse_wheel_down() {

        Player.ammo[1] += 200
        Player.ammo[2] += 20
        Player.ammo[3] += 20
        Player.ammo[4] += 20
        Player.ammo[5] += 20

        if wep > 1 wep -= 1
        else wep = maxwep
    }

    if keyboard_check_pressed(ord("1")) {
        GameCont.area = 1
        GameCont.subarea = 0
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }

    if keyboard_check_pressed(ord("2")) {
        GameCont.area = 1
        GameCont.subarea = 3
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }

    if keyboard_check_pressed(ord("3")) {
        GameCont.area = 3
        GameCont.subarea = 2
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }

    if keyboard_check_pressed(ord("4")) {
        GameCont.area = 3
        GameCont.subarea = 3
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }
    if keyboard_check_pressed(ord("5")) {
        GameCont.area = 5
        GameCont.subarea = 0
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }
    if keyboard_check_pressed(ord("6")) {
        GameCont.area = 5
        GameCont.subarea = 3
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }
    if keyboard_check_pressed(ord("7")) {
        GameCont.area = 7
        GameCont.subarea = 0
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }
    if keyboard_check_pressed(ord("8")) {
        GameCont.area = 106
        GameCont.subarea = 2
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }
    if keyboard_check_pressed(ord("9")) {
        GameCont.area = 103
        GameCont.subarea = 0
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }


    if keyboard_check_pressed(ord("0")) {
        GameCont.area = 100
        GameCont.subarea = 0
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }

    if keyboard_check_pressed(ord("L")) {
        GameCont.loops += 1
        with enemy
        hp = 0
        with instance_create(x, y, Portal) type = 1
    }

    if keyboard_check_pressed(ord("V")) {
        with instance_create(x, y, Portal) {
            sprite_index = sprPortalDisappear
            event_perform(ev_other, ev_animation_end)
        }
    }

    if keyboard_check_pressed(ord("C")) {
        instance_create(mouse_x, mouse_y, DogGuardian)
    }

    if keyboard_check_pressed(ord("P")) {
        instance_create(mouse_x, mouse_y, SnowTank)
    }

    if keyboard_check(ord("B")) {
        if keyboard_check(vk_shift) repeat 10 instance_create(x, y, BigRad)
        else instance_create(x, y, BigRad)
    }

    if keyboard_check_pressed(ord("K")) {
        with enemy
        hp = 0
    }

}

//*/