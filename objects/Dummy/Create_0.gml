raddrop = 0
max_hp = 1000
meleedamage = 0
size = 1

spr_idle = sprTargetIdle
spr_walk = sprTargetIdle
spr_hurt = sprTargetHurt
spr_dead = sprTargetDead

event_inherited()

snd_hurt = sndHitFlesh
snd_dead = sndBanditDie

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

move_contact_solid(random_angle, random(12))

//behavior
walk = 0
gunangle = 0
alarm[1] = -1
wkick = 0

friction = 1000

right = choose(-1, 1)