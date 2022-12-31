max_hp = 1
hp = 1
size = 1
spr_idle = sprBigTVOff
spr_hurt = sprBigTVDead
spr_dead = sprBigTVDead

event_inherited()

snd_hurt = sndHitMetal

spr_sit = sprMutant1Sit
spr_gosit = sprMutant1GoSit
spr_pidle = sprMutant1Idle

player = noone

with Player {
    if is_me {
        other.spr_sit = spr_sit
        other.spr_gosit = spr_gosit
        other.spr_pidle = spr_idle
        other.player = id
    }
}

playersprite = spr_pidle

drawframe = 0

image_speed = 0.4