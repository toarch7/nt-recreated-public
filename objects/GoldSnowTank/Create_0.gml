raddrop = 13
max_hp = 70
meleedamage = 0
size = 2

spr_idle = sprGoldTankIdle
spr_walk = sprGoldTankWalk
spr_hurt = sprGoldTankHurt
spr_dead = sprGoldTankDead

event_inherited()
hitid = HitId.GoldenSnowTank
corpse = false

snd_hurt = sndGoldTankHurt
snd_dead = sndGoldTankDead

alarm[1] = 120 + random(10)

ammo = 0
gunangle = random_angle

spr_shadow = shd32
spr_shadow_y = 3

rest = 0
wave = 0