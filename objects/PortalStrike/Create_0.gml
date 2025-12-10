expl_x = 0
expl_y = 0

ammo = 5

if scr_skill_get(5)
	sprite_index = sprRogueStrikeTB

snd_play(sndRogueAim)

snd = sndPortalStrikeFire

if instance_exists(Player) && scr_skill_get(5)
    snd = sndPortalStrikeFireButt

snd_play_loop(sndPortalStrikeLoop)

touch = -1