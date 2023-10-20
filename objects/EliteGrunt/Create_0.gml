raddrop = 0
max_hp = 40
meleedamage = 0
size = 1

spr_idle = sprEliteGruntIdle
spr_walk = sprEliteGruntWalk
spr_hurt = sprEliteGruntHurt
spr_dead = sprEliteGruntDead

snd_play_hit_big(sndEliteGruntEnter, 0.2)

event_inherited()

snd_hurt = sndEliteGruntHurt
snd_dead = sndEliteGruntDead

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 30
grenades = 4
gunangle = random_angle
alarm[1] = 25
wkick = 0
roll = 1
angle = 0
ammo = 3
fuel = 100
freeze = 0