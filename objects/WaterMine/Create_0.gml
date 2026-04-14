max_hp = 20

spr_idle = sprWaterMine
spr_hurt = sprWaterMineHurt
spr_dead = sprWaterMineDead

size = 1
event_inherited()

snd_hurt = sndHitMetal
friction = 10

image_xscale = choose(-1, 1)

if (!place_meeting(x, y, Floor)) instance_destroy(id, false)
