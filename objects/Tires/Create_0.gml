max_hp = 6
size = 1

spr_idle = sprTires
spr_hurt = sprTiresHurt
spr_dead = sprTiresDead

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))


snd_hurt = sndHitPlant
snd_dead = sndWheelPileBreak