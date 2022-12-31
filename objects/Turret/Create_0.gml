raddrop = 1
max_hp = 40
meleedamage = 0
size = 1
hit_id = sprTurtleIdle
spr_idle = sprTurretAppear
spr_walk = sprTurretIdle
spr_hurt = sprTurretHurt
spr_dead = sprTurretDead
event_inherited()
spr_fire = sprTurretFire
snd_hurt = sndTurretHurt
snd_dead = sndTurretDead
snd_play_hit_big(sndTurretSpawn, 0.2)
alarm[1] = (60 + random(60))
ammo = 0
gunangle = random(360)
offset = 0
alarm[3] = 1