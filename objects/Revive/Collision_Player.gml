if (GameCont.tottimer - starttimer < 30) or(other.inframes or other.bleed) && other.object_index == Player exit

hp = clamp(ceil(other.hp / 2), 1, max_hp)

with other {
    inframes = 10

    sprite_index = spr_hurt
    image_index = 0

    snd_play_hit(snd_hurt, 0.2)

    hp = round(hp / 2)

    if speed < 4 {
        motion_add(point_direction(other.x, other.y, x, y), 4)
    }
}

with Corpse {
    if sprite_index == other.spr_dead {
        instance_destroy()
    }
}

var player = id
instance_change(Player, 0)

with player {
    repeat 2 {
        with instance_nearest(x, y, WepPickup) if !curse {
            if !other.wep {
                other.wep = wep
                instance_destroy()
            } else {
                var _wep = other.wep
                other.bwep = _wep
                other.wep = wep
                instance_destroy()
            }
        }
    }

    inframes = 10

    sprite_index = spr_hurt
    image_index = 0

    if speed < 4 {
        motion_add(point_direction(other.x, other.y, x, y), 4)
    }

    spirit = skill_get(27)

    if spirit {
        can_spirit = 1
        spirit_index = 0
    }

    reload = 1
    breload = 1

    snd_play(snd_lowh)
}

image_alpha = 1
mask_index = mskPlayer
visible = 1

if race == 13 {
    mask_index = mskScrapBoss
}