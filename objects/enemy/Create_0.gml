event_inherited()
wkick = 0
image_speed = 0.4
friction = 0.4
right = choose(1, -1)

max_hp *= 1 + GameCont.loops / 20
hp = max_hp

gunangle = 0

canmelee = 1

scrEnemyApplyCreationEffects()

target = noone
team = team_enemy

givekill = true
corpse = true

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie
snd_mele = sndMaggotBite

dropseed = rng_next_int(RNGStates.WeaponDrops)

busycollisions = GameCont.loops <= 3