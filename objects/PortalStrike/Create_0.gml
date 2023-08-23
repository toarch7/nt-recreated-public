expl_x = 0
expl_y = 0

ammo = 5

if skill_get(5)
	sprite_index = sprRogueStrikeTB

snd_play(sndRogueAim)

snd = sndPortalStrikeFire

if instance_exists(Player) && skill_get(5)
    snd = sndPortalStrikeFireButt

snd_loop(sndPortalStrikeLoop)

touch = -1