raddrop = 0
max_hp = 100
meleedamage = 0
size = 1


spr_idle = sprEliteShielderIdle
spr_walk = sprEliteShielderWalk
spr_hurt = sprEliteShielderHurt
spr_dead = sprEliteShielderDead

event_inherited()

snd_hurt = sndEliteShielderHurt
snd_dead = sndEliteShielderDead
snd_play_hit(sndEliteShielderEnter, 0.2)

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 30
gunangle = random(360)
alarm[1] = 30 + random(15)
wkick = 0
roll = 1
angle = 0
ammo = 10

freeze = 20