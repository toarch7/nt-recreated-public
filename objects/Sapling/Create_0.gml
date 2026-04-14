event_inherited()

creator = noone
team = team_player
right = choose(1, -1)
size = 1

image_speed = 0.4
friction = 0.1

max_hp = 12
hp = max_hp

spr_idle = sprSaplingIdle
spr_walk = sprSaplingIdle
spr_hurt = sprSaplingHurt
spr_dead = sprSaplingDead

target = noone

snd_hurt = sndHitPlant
snd_dead = sndEnemyDie
snd_mele = sndMaggotBite

sprite_index = sprSaplingAppear

walk = 0
alarm[0] = 30

wantdir = random_angle

snd_play_hit(sndSaplingSpawn, 0.2)