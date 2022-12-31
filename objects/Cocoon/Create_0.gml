max_hp = 8
size = 1

spr_idle = sprCocoon
spr_hurt = sprCocoonHurt
spr_dead = sprCocoonDead

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))


snd_hurt = sndHitPlant