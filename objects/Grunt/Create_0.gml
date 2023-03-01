raddrop = 0
max_hp = 8
meleedamage = 0
size = 1

spr_idle = sprGruntIdle
spr_walk = sprGruntWalk
spr_hurt = sprGruntHurt
spr_dead = sprGruntDead

event_inherited()

snd_hurt = sndGruntHurt
snd_dead = sndGruntDead

male = 1

if irandom(1) {
    snd_hurt = sndGruntHurtF
    snd_dead = sndGruntDeadF
    snd_play_hit_big(sndGruntEnterF, 0.2)
    male = 0
} else {
    snd_play_hit_big(sndGruntEnter, 0.2)
}

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 0
grenades = 2
gunangle = random(360)
alarm[1] = 30 + random(15)
wkick = 0
roll = 1
angle = 0

freeze = 0
lastx = x
lasty = y