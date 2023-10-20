raddrop = 2
max_hp = 4
meleedamage = 0
size = 1

spr_idle = sprBanditIdle
spr_walk = sprBanditWalk
spr_hurt = sprBanditHurt
spr_dead = sprBanditDead

event_inherited()

snd_hurt = sndBanditHit
snd_dead = sndBanditDie

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0

if random(1) < .1 {
    if UberCont.xmas {
        spr_idle = sprSnowBanditIdle
        spr_walk = sprSnowBanditWalk
        spr_hurt = sprSnowBanditHurt
        spr_dead = sprSnowBanditDead
    } else if UberCont.halloween {
        spr_idle = sprSpookyBanditIdle
        spr_walk = sprSpookyBanditWalk
        spr_hurt = sprSpookyBanditHurt
        spr_dead = sprSpookyBanditDead
    }
}

if GameCont.area == 5 {
    spr_idle = sprSnowBanditIdle
    spr_walk = sprSnowBanditWalk
    spr_hurt = sprSnowBanditHurt
    spr_dead = sprSnowBanditDead
}