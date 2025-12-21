if (!instance_exists(creator)) {
	instance_destroy()
	exit
}

x = creator.x
y = creator.y + 48

if (charge) {
    with (instance_create(x, y - 16, NothingBeamChargeParticle)) {
        var _angle = random_angle,
			_distance = 16 + random(64)
		
        x += ldrx(_distance, _angle)
        y += ldry(_distance, _angle)
        
		motion_add(
			point_direction(x, y, xstart, ystart),
			point_distance(x, y, xstart, ystart) / 20)
        
		image_angle = direction
    }
	exit
}

image_yscale = 1

repeat (1024) {
	image_yscale --
	if (place_meeting(x, y, Wall)) {
		break
	}
}

instance_create(x + orandom(20), y + orandom(1) + image_yscale, NothingBeamHit)

with (BackCont) shake = min(shake, 3)

if (!disappear) {
    with instance_create(
		x + orandom(20),
		creator.y + 48 + random(24),
		NothingBeamParticle
	) {
        vspeed = 12 + random(10)
        image_angle = direction
    }
}