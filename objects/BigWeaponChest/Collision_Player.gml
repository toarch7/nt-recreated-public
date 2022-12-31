if !instance_exists(GenCont) {

    random_set_seed(x + y)

    GameCont.nochest = 0
    instance_create(x, y, PortalClear)

    with instance_create(x - 8, y, WepPickup) {
        scrWeapons()
        scrDecideWep(1)
        name = wep_name[wep]
        ammo = 50
        curse = 0
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
    }
    with instance_create(x, y, WepPickup) {
        scrWeapons()
        scrDecideWep(1)
        name = wep_name[wep]
        ammo = 50
        curse = 0
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
    }
    with instance_create(x + 8, y, WepPickup) {
        scrWeapons()
        scrDecideWep(1)
        name = wep_name[wep]
        ammo = 50
        curse = 0
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
    }

    if GameCont.crown == 6 {
        with other {
            hp -= 1
            sprite_index = spr_hurt
            image_index = 0
            snd_play_hit(snd_hurt, .2)
            last_hit = sprCrown6Idle

            repeat(16) {
                with instance_create(x, y, Rad)
                motion_add(random(360), 2 + random(4))
            }
        }
    }

    snd_play(sndBigWeaponChest)
    snd_play(Player.snd_chst)
    instance_destroy()
}