if !instance_exists(GenCont) {
    if GameCont.crown == 6 {
        with other {
            hp -= 1
            last_hit = sprCrown6Idle
            sprite_index = spr_hurt
            image_index = 0
			last_hit = sprCrown6Idle
			
            snd_play(snd_hurt)
            repeat 16 {
                with instance_create(x, y, Rad)
                motion_add(random(360), 2 + random(4))
            }
        }
    }
    
    instance_create(x, y, VenuzAmmoSpawn)
    snd_play(sndBigWeaponChest)
    snd_play(Player.snd_chst)
    instance_destroy()
}

