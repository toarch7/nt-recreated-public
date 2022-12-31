max_hp = 1
size = 1

spr_idle = sprBushIdle
spr_hurt = sprBushHurt
spr_dead = sprBushDead

event_inherited()

move_contact_solid(random(360), random(64))

snd_hurt = sndHitPlant