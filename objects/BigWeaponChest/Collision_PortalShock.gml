GameCont.nochest = 0
with instance_create(x - 8, y, WepPickup) {
    scrWeapons()
    scrDecideWep(1)
    name = wep_name[wep]
    type = wep_type[wep]
    ammo = 50
    curse = 0
    sprite_index = wep_sprt[wep]
}
with instance_create(x, y, WepPickup) {
    scrWeapons()
    scrDecideWep(1)
    name = wep_name[wep]
    type = wep_type[wep]
    ammo = 50
    curse = 0
    sprite_index = wep_sprt[wep]
}
with instance_create(x + 8, y, WepPickup) {
    scrWeapons()
    scrDecideWep(1)
    name = wep_name[wep]
    type = wep_type[wep]
    ammo = 50
    curse = 0
    sprite_index = wep_sprt[wep]
}


snd_play(sndBigWeaponChest)
instance_destroy()