if !instance_exists(GenCont) {
    snd_play_pitch(sndCursedChest, .5)
    GameCont.nochest = 0
    with instance_create(x - 8, y, WepPickup) {
        scrWeapons()
        scrDecideWep(3)
        name = wep_name[wep]
        ammo = 50
        curse = 1
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
    }
    with instance_create(x, y, WepPickup) {
        scrWeapons()
        scrDecideWep(3)
        name = wep_name[wep]
        ammo = 50
        curse = 1
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
    }
    with instance_create(x + 8, y, WepPickup) {
        scrWeapons()
        scrDecideWep(3)
        name = wep_name[wep]
        ammo = 50
        curse = 1
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
    snd_play(other.snd_chst)
    instance_destroy()
}