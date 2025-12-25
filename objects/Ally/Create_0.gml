event_inherited()

wkick = -1
raddrop = 5
max_hp = 12

buttgot = scr_skill_get(mut_throne_butt)
bskin = SkinLetter.A
setup = true

if (scr_ultra_get(Race.Rebel, UltraSkill.PersonalGuard)) max_hp = 30

meleedamage = 0
size = 3
spr_appear = sprAllyAppear
spr_idle = sprAllyIdle
spr_walk = sprAllyWalk
spr_hurt = sprAllyHurt
spr_dead = sprAllyDead
image_speed = 0.4
friction = 0.4
right = choose(1, -1)
hp = max_hp
target = noone
team = 2
snd_hurt = sndAllyHurt
snd_dead = sndAllyDead
walk = 0
gunangle = random_angle
alarm[1] = 60
wkick = 0
alarm[2] = 160
snd_play_hit_big(sndAllySpawn, 0.2)