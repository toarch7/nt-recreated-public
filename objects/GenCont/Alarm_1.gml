instance_destroy()

//snd_play(sndAreaLoaded)

scrMoveTopPots()

if instance_exists(Player) {
    with Crown {
        if is_new {
            if !(GameCont.area == 7 && GameCont.subarea == 3) {
                instance_create(x, y, IDPDSpawn)
            }

            is_new = 0
        }
    }

    with Player
    if is_me {
        drawempty = 30
        drawlowhp = 30
    }

    with instance_random(Player) {
        if GameCont.area == 100 {
            snd_play(snd_valt)
        } else if GameCont.subarea == 1 {
            snd_play(snd_wrld)

            if GameCont.area == 106 {
                var s = asset_get_index("sndMutant" + string(race) + "IDPD")

                if sound_exists(s) {
                    snd_play_hit_big(s, 0.1)
                }
            }
        }
    }

    with Player {
        if race == 6 {
            BackCont.shake += 5
            snd_play(sndVenuz)
        }
    }

    if GameCont.area == 103 {
        with WeaponChest {
            instance_create(x, y, GoldChest)
            instance_change(Wind, false)
        }
    }

    if !instance_exists(Cinematic) snd_play(sndPortalOpen)

    with Player {
        x = 10016
        y = 10016

        if race == 13 {
            with instance_create(x, y, PortalClear) {
                image_xscale = 3
                image_yscale = 3
            }
        } else instance_create(x, y, PortalClear)
    }
}

with CrownPickup {
    with Torch {
        if point_distance(x, y, other.x, other.y) < 240 {
            target = noone
            instance_change(WepSwap, false)
        }
    }
}

with Wall {
    if place_free(x - 16, y) l = 0
    else l = 4

    if place_free(x + 16, y) w = 24 - l
    else w = 20 - l

    if place_free(x, y - 16) r = 0
    else r = 4

    if place_free(x, y + 16) h = 24 - r
    else h = 20 - r
}

//with WeaponChest
//instance_create(x,y,DramaCamera)

instance_activate_object(Bones)

if GameCont.area == 104 {
    with WeaponChest {
        instance_create(x, y, CursedBigChest)
        instance_destroy(id, 0)
    }

    with BigWeaponChest {
        instance_create(x, y, CursedBigChest)
        instance_destroy(id, 0)
    }
}