event_inherited()

max_hp = INT_MAX
hp = max_hp
meleedamage = 0
size = 8

spr_idle = sprNothingOn
spr_hurt = sprNothingHurt
spr_dead = sprNothingDead

drawimg = 0

image_speed = 0.4
alarm[0] = 200
alarm[4] = 170

BackCont.shake = 5

deadanim = 0
team = 1
hit_id = sprKilledByThrone

snd_hurt = sndHitRock

instance_create(x, y + 32, NothingPipes)