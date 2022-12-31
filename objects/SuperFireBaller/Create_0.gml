raddrop = 15
max_hp = 60
meleedamage = 1
size = 1

spr_idle = sprSuperFireBallerIdle
spr_walk = sprSuperFireBallerIdle
spr_hurt = sprSuperFireBallerHurt
spr_dead = sprSuperFireBallerDead
spr_fire = sprSuperFireBallerFire

event_inherited()

snd_hurt = sndSuperFireballerHurt
snd_dead = sndSuperFireballerDead

spr_shadow = shd32

//behavior
alarm[1] = 10 + random(10)

if instance_exists(Player) motion_add(point_direction(Player.x, Player.y, x, y), 1)