raddrop = 20
max_hp = 18
meleedamage = 3
size = 1

spr_idle = sprInvSpiderIdle
spr_walk = sprInvSpiderWalk
spr_hurt = sprInvSpiderHurt
spr_dead = sprInvSpiderDead

event_inherited()

snd_hurt = choose(sndLaserCrystalHit, sndRavenHit, sndSniperHit, sndBanditHit, sndHitFlesh)
snd_dead = choose(sndLaserCrystalDeath, sndRavenDie, sndBanditDie, sndEnemyDie)

//behavior
walk = 0
alarm[1] = 30 + random(90)
maxspeed = 3