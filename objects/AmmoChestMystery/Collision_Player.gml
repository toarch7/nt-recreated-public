if !instance_exists(GenCont) {

    if other.race == 7 && other.ultra == 2 {

        for (i = 1; i <= 5; i++) {

            if i == other.wep_type[other.wep] or i == other.wep_type[other.bwep]
            continue
            type = i

            other.ammo[type] += other.typ_ammo[type] * 3
            if other.ammo[type] > other.typ_amax[type] other.ammo[type] = other.typ_amax[type]

            dir = instance_create(x, y, PopupText)
            dir.mytext = "+" + string(other.typ_ammo[type] * 3) + " " + string(loc(other.typ_name[type]))
            if other.ammo[type] = other.typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(other.typ_name[type]))

            snd_play(sndAmmoChest)

        }

        instance_destroy()
        exit

    }

    do type = choose(1, 2, 3, 4, 5) until type != other.wep_type[other.wep] and type != other.wep_type[other.bwep]

    other.ammo[type] += other.typ_ammo[type] * 3
    if other.ammo[type] > other.typ_amax[type] other.ammo[type] = other.typ_amax[type]

    dir = instance_create(x, y, PopupText)
    dir.mytext = "+" + string(other.typ_ammo[type] * 3) + " " + string(loc(other.typ_name[type]))
    if other.ammo[type] = other.typ_amax[type] dir.mytext = loc_sfmt("MAX %", loc(other.typ_name[type]))

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

    snd_play(sndAmmoChest)
    instance_destroy()
}