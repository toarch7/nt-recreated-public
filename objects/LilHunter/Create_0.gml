raddrop = 20
max_hp = 140 * (1 + (GameCont.loops / 3))
meleedamage = 0
hit_id = sprLilHunter
size = 1
spr_idle = sprLilHunter
spr_walk = sprLilHunter
spr_hurt = sprLilHunterHurt
spr_dead = sprLilHunterDead
event_inherited()
snd_hurt = sndLilHunterHurt
snd_dead = sndLilHunterDeath
walk = 0
gunangle = random_angle
wkick = 0
dodge = 0
z = 0
intro = 0
spawns = 6

alarm[2] = 210 / (GameCont.loops + 1)
alarm[1] = alarm[2] + 30

if alarm[2] < 1 {
    alarm[2] = 1
}

sndtaunt = 0
tauntdelay = 0
sndhalfhp = 0