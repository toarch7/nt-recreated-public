raddrop = 0
max_hp = 22
meleedamage = 5
size = 1

spr_idle = sprScrapBossMissileIdle
spr_walk = sprScrapBossMissileIdle
spr_hurt = sprScrapBossMissileHurt
spr_dead = sprScrapBossMissileDead

event_inherited()

snd_hurt = sndHitMetal

scrTarget()
raddrop = 0
givekill = 0
spr_shadow_y = 3

if GameCont.loops alarm[0] = max(1, 12 - GameCont.loops)