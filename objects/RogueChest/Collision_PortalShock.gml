if !instance_exists(Player) exit

with instance_create(x, y, ChestOpen) {
    size = other.size
    mask_index = other.mask_index
    sprite_index = sprRogueChestOpen
}

with Player {
    if race == 12 {
        amount = 1 + (ultra == 1)
        if rogue_ammo < rogue_ammo_max {
            with instance_create(x, y, PopupText)
            mytext = "+" + string(other.amount) + " PORTAL STRIKE" + qm(other.amount > 1, "S", "")

            rogue_ammo += amount
        } else with instance_create(x, y, PopupText) mytext = "MAX PORTAL STRIKES"
    }
}

instance_destroy()
snd_play(sndAmmoPickup)