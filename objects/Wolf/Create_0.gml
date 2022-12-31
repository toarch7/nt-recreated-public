raddrop = 6
max_hp = 16
meleedamage = 3
size = 1

spr_idle = sprWolfIdle
spr_walk = sprWolfWalk
spr_hurt = sprWolfHurt
spr_dead = sprWolfDead
spr_fire = sprWolfFire

event_inherited()

snd_dead = sndWolfDead
snd_hurt = sndWolfHurt

//behavior
alarm[1] = 60 + random(40)

if instance_exists(Player) motion_add(point_direction(Player.x, Player.y, x, y), 1)

close = 0

walk = 30