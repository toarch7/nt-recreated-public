raddrop = 5
max_hp = 5
meleedamage = 0
size = 1

spr_idle = sprExploderIdle
spr_walk = sprExploderWalk
spr_hurt = sprExploderHurt
spr_dead = sprExploderDead

event_inherited()

snd_dead = sndFrogExplode

//behavior
alarm[1] = 40 + random(40)

motion_add(point_direction(10016, 10016, x, y), 1)

close = 0