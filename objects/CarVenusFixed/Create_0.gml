size = 1

event_inherited()

max_hp = 25
hp = max_hp

spr_idle = sprVenusCarFixed
spr_hurt = sprVenusCarFixedHurt
spr_dead = sprScorchmark

snd_hurt = sndHitMetal

image_xscale = choose(1, -1)

hitid = HitId.VenusCarFixed

if (GameCont.area == area_crib && random(1) < 0.5) {
	spr_idle = sprVenuzCar2
	spr_hurt = sprVenuzCar2Hurt
	sprite_index = spr_idle
}

name = "CAR"

friction = 1.5