max_hp = 15
size = 1

spr_idle = sprYVStatue
spr_hurt = sprYVStatueHurt
spr_dead = sprYVStatueDead

event_inherited()

move_contact_solid(random(360), random(12))
if !place_free(x, y + 12) move_contact_solid(random(90) + 45, random(12))


snd_hurt = sndHitRock