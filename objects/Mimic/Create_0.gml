raddrop = 6
max_hp = 4
meleedamage = 3
size = 0

spr_idle = sprMimicIdle
spr_walk = sprMimicFire
spr_hurt = sprMimicHurt
spr_dead = sprMimicDead

event_inherited()

snd_hurt = sndMimicHurt
snd_dead = sndMimicDead
snd_mele = sndMimicMelee

//behavior
alarm[1] = 90 + random(150)

if place_free(x, y - 12) move_contact_solid(90, 12)