raddrop = 15
max_hp = 15
meleedamage = 4
size = 0

spr_idle = sprSuperMimicIdle
spr_walk = sprSuperMimicFire
spr_hurt = sprSuperMimicHurt
spr_dead = sprSuperMimicDead

event_inherited()

snd_hurt = sndMimicHurt
snd_dead = sndMimicDead
snd_mele = sndMimicMelee

//behavior
alarm[1] = 90 + random(150)

if place_free(x, y - 12) move_contact_solid(90, 12)