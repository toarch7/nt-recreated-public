event_inherited()
wkick = 0
image_speed = 0.4
friction = 0.4
right = choose(1, -1)

max_hp *= 1 + GameCont.loops / 20
hp = max_hp

inframes = 0
gunangle = 0

canmelee = 1

scrEnemyApplyCreationEffects()

team = 1
target = noone
hit_id = spr_idle

givekill = true
corpse = true

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie
snd_mele = sndMaggotBite

dropseed = rng_next_int(RNGStates.Drops)