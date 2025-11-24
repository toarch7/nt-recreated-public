raddrop = 15
max_hp = 50
meleedamage = 2
size = 2

spr_idle = sprExploGuardianIdle
spr_walk = sprExploGuardianIdle
spr_hurt = sprExploGuardianHurt
spr_dead = sprExploGuardianDead
spr_chrg = sprExploGuardianCharge
spr_fire = sprExploGuardianFire

event_inherited()

charge = 0

snd_hurt = sndExploGuardianHurt
snd_dead = sndExploGuardianDead

//behavior
alarm[1] = 20 + random(10)

walk = 0
spr_shadow = shd32
spr_shadow_y = 8