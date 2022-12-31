if !instance_exists(GenCont) {
    with instance_create(x, y, WepPickup) {
        scrWeapons()
        scrDecideWepGold(1)
        name = wep_name[wep]
        ammo = 50
        type = wep_type[wep]
        curse = 0
        sprite_index = wep_sprt[wep]
    }

    snd_play(sndWeaponChest)
    instance_destroy()
}