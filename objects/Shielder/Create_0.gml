raddrop = 0
max_hp = 50
meleedamage = 0
size = 1


spr_idle = sprShielderIdle
spr_walk = sprShielderWalk
spr_hurt = sprShielderHurt
spr_dead = sprShielderDead

event_inherited()

snd_hurt = sndShielderHurt
snd_dead = sndShielderDead

male = 1
if irandom(1) {
    snd_hurt = sndShielderHurtF
    snd_dead = sndShielderDeadF
    snd_play_hit_big(sndShielderEnterF, 0.2)
    male = 0
} else {
    snd_play_hit_big(sndShielderEnter, 0.2)
}

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(15)
wkick = 0
roll = 1
angle = 0
ammo = 10

freeze = 20