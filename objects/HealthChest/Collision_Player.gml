if !instance_exists(GenCont) {
    num = 4
    if skill_get(9) num = 8

    with other {
        if headloses {
            headloses--max_hp++
        }
    }

    instance_create(x, y, HealFX)

    instance_destroy()
    other.hp += num
    if other.hp > other.max_hp other.hp = other.max_hp


    dir = instance_create(x, y, PopupText)
    dir.mytext = "+" + string(num) + " HP"
    if other.hp = other.max_hp dir.mytext = "MAX HP"

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

    snd_play(sndHealthChest)
    instance_destroy()
}