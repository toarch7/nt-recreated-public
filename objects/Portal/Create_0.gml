image_speed = 0.4

endgame = 100

if GameCont.area != 101 {
    snd_play(sndPortalOpen)
    snd_loop(sndPortalLoop)
} else snd_play(sndOasisPortal)

if instance_exists(Player) {
    with projectile {
        if team != Player.team instance_destroy(id, 0)
    }
}

instance_create(x, y, PortalClear)
instance_create(x, y, PortalShock)

with prop {
    if distance_to_object(other) <= 32 {
        hp = 0
    }
}

if instance_exists(Player) {
    with WeaponChest {
        if distance_to_object(other) <= 48 {
            repeat 1 + (object_index == BigWeaponChest or object_index == CursedBigChest) * 2 {
                pickup = instance_create(x + random_spread(1), y + random_spread(1), WepPickup)

                with pickup {
                    scrWeapons()
                    scrDecideWep(1 + other.curse * 2)
                    name = wep_name[wep]
                    ammo = 50
                    type = wep_type[wep]
                    curse = other.curse
                    sprite_index = wep_sprt[wep]
                }

                if curse {
                    if object_index == CursedBigChest {
                        snd_play_pitch(sndCursedChest, .5)
                    } else snd_play(sndCursedChest)
                }

                if Player.race == 7 && Player.ultra == 1 with pickup {
                    instance_copy(0)
                    motion_add(random(360), 2)
                }

                instance_destroy()
                snd_play(sndWeaponChest)
            }

            GameCont.nochest = 0
        }
    }
}

with AmmoChest {
    if distance_to_object(other) <= 48 {
        repeat 2 instance_create(x, y, AmmoPickup)
        instance_destroy()
    }
}

with HealthChest {
    if distance_to_object(other) <= 48 {
        repeat 2 instance_create(x, y, HPPickup)
        instance_destroy()
    }
}

with RogueChest {
    if distance_to_object(other) <= 48 {
        with Player {
            if race == 12 {
                with other {
                    event_perform(ev_collision, Player)
                }
            }
        }
    }
}

if instance_exists(Player) && Player.race == 12 {
    repeat 2 {
        instance_create(x, y, IDPDSpawn)
    }

    GameCont.popolevel -= 1.5
}