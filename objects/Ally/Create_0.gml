event_inherited()

skill_got[14] = 0
wkick = -1
spr_chrg = -1
spr_fire = -1
raddrop = 5
max_hp = 12

if instance_exists(Player) && ultra_get(2) {
    max_hp = 30
}

meleedamage = 0
size = 3
spr_idle = sprAllyAppear
spr_walk = sprAllyWalk
spr_hurt = sprAllyHurt
spr_dead = sprAllyDead
image_speed = 0.4
friction = 0.4
right = choose(1, - 1)
hp = max_hp
target = -1
team = 2
snd_hurt = sndAllyHurt
snd_dead = sndAllyDead
walk = 0
inframes = 0
gunangle = random(360)
alarm[1] = 60
wkick = 0
alarm[2] = 160
snd_play_hit_big(sndAllySpawn, 0.2)