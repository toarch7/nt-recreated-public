if GameCont.area == 0 {instance_destroy(id, 0); exit}

friction = 0.4

team = 0
size = 2

max_hp = 20

event_inherited()
image_speed = 0

spr_idle = sprRadChestBigIdle
spr_hurt = sprRadChestBigHurt
spr_dead = sprRadChestBigDead

snd_hurt = sndHitMetal

hp = max_hp
raddrop = 45

