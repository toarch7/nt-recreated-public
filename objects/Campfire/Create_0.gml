max_hp = 1000000


spr_idle = sprCampfire
if random(200) < 1 {
    spr_idle = sprCampfireBear
    MusCont.alarm[6] = 2500
}

spr_hurt = sprBarrelHurt
spr_dead = sprBarrelDead
size = 1

event_inherited()
image_speed = 0.4