max_hp = 2
size = 1

spr_idle = sprCrystalProp
spr_hurt = sprCrystalPropHurt
spr_dead = sprCrystalPropDead

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))


snd_hurt = sndHitRock