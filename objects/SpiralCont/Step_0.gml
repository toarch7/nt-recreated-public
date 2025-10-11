if lockstep_stop
	exit

if type == 2 {
    image_angle += 10 + sin(image_angle / 300) * 2 + random(1)
}
else {
    image_angle += 8 + sin(image_angle / 300) * 1
}

time++

var _cx = view_width div 2, _cy = view_height div 2

if type == SpiralType.IDPD || type == SpiralType.Venuz {
    x = _cx
    y = _cy
}
else {
	x = _cx + sin(image_angle / 921) * sin(image_angle / 500) * 80
	y = _cy + cos(image_angle / 583) * sin(image_angle / 500) * 50
}

if random(16) < 1 && type != 4 {
    if (type == SpiralType.IDPD || (random(3) < 1)) && !bossfight {
        with instance_create(x, y, SpiralDebris) {
            depth = other.image_angle
        }
    }
}


if type != SpiralType.Venuz {
    with instance_create(x, y, Spiral) {
        image_xscale = 0
        image_yscale = 0

        depth = other.image_angle
        image_angle = other.image_angle
		
        if other.type == SpiralType.IDPD {
            sprite_index = sprSpiralIDPD
			
            if other.time % 11 <= 1 {
                sprite_index = sprSpiralIDPD2
            }
			
            x = _cx
            y = _cy
        }
		
        if other.type == SpiralType.Proto {
            sprite_index = sprSpiralProto
            image_xscale = random(0.01)
            image_yscale = image_xscale
        }
    }
}
else {
	instance_create(x, y, SpiralStar)
}

if (area == 0 && !instance_exists(NothingSpiral)) or area != 0 {
	if !instance_exists(LevCont) && !instance_exists(GenCont)
	&& !instance_exists(SitDown) && instance_exists(BackCont)
	&& !instance_exists(Credits) && active
		instance_destroy()
}