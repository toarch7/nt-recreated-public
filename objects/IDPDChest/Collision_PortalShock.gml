if instance_exists(GenCont) exit

repeat 8 {
    instance_create(x, y, AmmoPickup)
}

snd_play(sndAmmoChest)

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

repeat 6
instance_create(x, y, IDPDSpawn)

instance_destroy()