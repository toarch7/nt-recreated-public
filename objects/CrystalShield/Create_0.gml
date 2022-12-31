time = 0
team = 2
p = 0

spr_idle = sprShield
spr_disappear = sprShieldDisappear

creator = noone

if instance_exists(Player) {
    var p = instance_nearest(x, y, Player)

    if p.bskin {
        spr_idle = sprShieldB
        spr_disappear = sprShieldBDisappear
    }

    if p.ultra == 2 {
        snd_play(sndCrystalJuggernaut)
    } else snd_play(sndCrystalShield)

    creator = p
}

sprite_index = spr_idle

walk = 0