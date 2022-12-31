max_hp = 8
size = 1

spr_idle = sprBigFlowerIdle
spr_hurt = sprBigFlowerHurt
spr_dead = sprBigFlowerDead

event_inherited()

move_contact_solid(random(360), random(64))

snd_hurt = sndHitPlant