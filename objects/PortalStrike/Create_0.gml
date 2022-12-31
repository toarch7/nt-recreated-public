expl_x = 0
expl_y = 0

ammo = 5

if instance_exists(Player) {
    if skill_get(5) {
        image_xscale += 0.1
        image_yscale += 0.1
    }
}

snd_play(sndRogueAim)

snd = sndPortalStrikeFire

if instance_exists(Player) && skill_get(5) {
    snd = sndPortalStrikeFireButt
}

snd_loop(sndPortalStrikeLoop)

touch = -1