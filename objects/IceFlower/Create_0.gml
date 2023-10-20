max_hp = 450

spr_idle = sprJungleFlowerIdle
spr_hurt = sprJungleFlowerHurt
spr_dead = sprJungleFlowerDead

size = 1

flr = instance_nearest(x, y, Floor)
x = flr.x + 16
y = flr.y + 16
move_contact_solid(random_angle, 16)

event_inherited()

snd_hurt = sndHitFlesh

snd_play(snd_hurt)

image_xscale = 1

name = "FEED"
feed = 0