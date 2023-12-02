raddrop = 25
max_hp = 45
meleedamage = 20
size = 2

spr_idle = sprInvLaserCrystalIdle
spr_walk = sprInvLaserCrystalIdle
spr_hurt = sprInvLaserCrystalHurt
spr_dead = sprInvLaserCrystalDead
spr_fire = sprInvLaserCrystalFire

event_inherited()

snd_hurt = choose(sndLaserCrystalHit, sndRavenHit, sndSniperHit, sndBanditHit, sndHitFlesh)
snd_dead = choose(sndLaserCrystalDeath, sndRavenDie, sndBanditDie, sndEnemyDie)


//behavior
ammo = 4
gunangle = random_angle
alarm[1] = 30 + random(90)

spr_shadow_y = 4