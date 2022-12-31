raddrop = 15
max_hp = 50
meleedamage = 2
size = 2

spr_idle = sprExploguardianIdle
spr_walk = sprExploguardianIdle
spr_hurt = sprExploguardianHurt
spr_dead = sprExploguardianDead
spr_chrg = sprExploguardianCharge
spr_fire = sprExploguardianFire

event_inherited()

charge = 0

snd_hurt = sndExploGuardianHurt
snd_dead = sndExploGuardianDead

//behavior
alarm[1] = 20 + random(10)

walk = 0
spr_shadow = shd32
spr_shadow_y = 8