if !instance_exists(GenCont) {

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

    if curse global.rng_state[3] += 1234

    pickup = instance_create(x, y, WepPickup)
    with pickup {
        scrWeapons()
        scrDecideWep(1 + other.curse * 2)
        name = wep_name[wep]
        ammo = 50
        type = wep_type[wep]
        curse = other.curse
        sprite_index = wep_sprt[wep]
    }

    if GameCont.area == 101 snd_play(sndOasisChest)
    else if curse {
        snd_play(sndCursedChest)
        global.rng_state[3] -= 1234
    } else snd_play(sndWeaponChest)

    if other.race == 7 && other.ultra == 1 with pickup {
        instance_copy(0)
        x = xprevious
        y = yprevious
    }


    instance_destroy()
}