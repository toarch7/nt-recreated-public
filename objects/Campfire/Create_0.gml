max_hp = 1_000_000


spr_idle = sprCampfire

if random(200) < 1 {
	with (MusCont) alarm[6] = 2500
    spr_idle = sprCampfireBear
}
image_xscale = choose(1, -1)
spr_hurt = sprBarrelHurt
spr_dead = sprBarrelDead
size = 1

event_inherited()
image_speed = 0.4