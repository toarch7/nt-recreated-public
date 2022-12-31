with instance_create(x, y, Corpse) {
    size = other.size
    mask_index = other.mask_index
    sprite_index = sprRogueChestOpen
}

if other.race != 12 {
    with instance_create(x, y, Corpse) {
        size = other.size
        mask_index = other.mask_index
        sprite_index = sprRogueChestOpen
    }

    repeat 25 {
        with instance_create(x, y, Rad)
        motion_add(random(360), random(5))
    }
} else with other {
    amount = 1 + (ultra == 1)
    if rogue_ammo < rogue_ammo_max {
        with instance_create(x, y, PopupText)
        mytext = "+" + string(other.amount) + " PORTAL STRIKE" + qm(other.amount > 1, "S", "")

        rogue_ammo += amount
    } else with instance_create(x, y, PopupText) mytext = "MAX PORTAL STRIKES"
}

if GameCont.crown == 6 {
    with other {
        hp -= 1
        sprite_index = spr_hurt
        image_index = 0
        snd_play_hit(snd_hurt, .2)

        repeat(16) {
            with instance_create(x, y, Rad)
            motion_add(random(360), 2 + random(4))
        }
    }
}

instance_destroy()
snd_play(sndAmmoPickup)