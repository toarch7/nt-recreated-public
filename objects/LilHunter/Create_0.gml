raddrop = 20
max_hp = 140 * (1 + (GameCont.loops / 3))
meleedamage = 0
size = 1
spr_idle = sprLilHunter
spr_walk = sprLilHunter
spr_hurt = sprLilHunterHurt
spr_dead = sprLilHunterDead
event_inherited()
hitid = HitId.LilHunter
snd_hurt = sndLilHunterHurt
snd_dead = sndLilHunterDeath
walk = 0
gunangle = random_angle
forceliftoff = false
wkick = 0
dodge = 0
z = 0
intro = 0
spawns = 6

alarm[1] = irandom_range(30, 120)
alarm[2] = 30

sndtaunt = 0
tauntdelay = 0
sndhalfhp = 0

hitid = HitId.LilHunter