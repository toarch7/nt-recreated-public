image_index = 0

size = 3
max_hp = 30
target = noone
spr_idle = sprScrapBossSleep
spr_hurt = sprScrapBossSleepHurt
spr_dead = sprScrapBossDead

event_inherited()

image_speed = 0.4
timer = 0

spr_shadow = shd96

dropseed = rng_next_int(RNGStates.WeaponDrops)