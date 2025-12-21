max_hp = 20

spr_idle = sprCarIdle
spr_hurt = sprCarHurt
spr_dead = sprScorchmark
hitid = HitId.Car

if GameCont.area == area_city {
    spr_idle = sprFrozenCar
    spr_hurt = sprFrozenCarHurt
    spr_dead = sprScorchmark
	hitid = HitId.IcyCar
}

size = 1

event_inherited()

snd_hurt = sndHitMetal
immmovable = false
