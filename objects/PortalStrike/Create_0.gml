setup = true

explo_x = 0
explo_y = 0
size = 28

ammo = 5

buttgot = scr_skill_get(mut_throne_butt)

if (buttgot) sprite_index = sprRogueStrikeTB

snd = buttgot ? sndPortalStrikeFireButt : sndPortalStrikeFire

snd_play_loop(sndPortalStrikeLoop)
snd_play(sndRogueAim)

touch = -1