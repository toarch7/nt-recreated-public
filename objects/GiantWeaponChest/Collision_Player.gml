if !instance_exists(GenCont) {
    if GameCont.crown == 6 {
        with other {
            hp--last_hit = sprCrown6Idle
            sprite_index = spr_hurt
            image_index = 0
            snd_play(snd_hurt)
            last_hit = sprCrown6Idle

            repeat 16 {
                with instance_create(x, y, Rad) {
                    motion_add(random(360), 2 + random(4))
                }
            }
        }
    }

    instance_create(x, y, VenuzWeaponSpawn)
    snd_play(sndBigWeaponChest)
    snd_play(other.snd_chst)
    instance_destroy()
}