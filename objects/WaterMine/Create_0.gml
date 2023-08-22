max_hp = 20

spr_idle = sprWaterMine
spr_hurt = sprWaterMineHurt
spr_dead = sprWaterMineDead

size = 1
event_inherited()

if place_empty(x, y)
instance_destroy(id, 0)

snd_hurt = sndHitMetal
friction = 10

image_xscale = choose(-1, 1)