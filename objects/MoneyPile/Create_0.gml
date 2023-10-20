max_hp = 1
size = 1

spr_idle = sprMoneyPile
spr_hurt = sprMoneyPileHurt
spr_dead = sprMoneyPileDead

event_inherited()

move_contact_solid(random_angle, random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))


snd_hurt = sndHitPlant