if type == SpiralType.Proto {
    image_angle += 10 + sin(image_angle / 300) * 2 + orandom(1)
}
else {
    image_angle += 8 + sin(image_angle / 300) * 1
}

time ++

var _cx = view_width div 2,
	_cy = view_height div 2

if (type == SpiralType.IDPD || type == SpiralType.Venuz) {
    x = _cx
    y = _cy
}
else {
	x = _cx + sin(image_angle / 921) * sin(image_angle / 500) * 80
	y = _cy + cos(image_angle / 583) * sin(image_angle / 500) * 50
}

if current_frame_active && random(16) < 1 && type != SpiralType.Venuz {
    if (type == SpiralType.Proto || random(3) < 1) && !bossfight {
        with (instance_create(x, y, SpiralDebris)) depth = other.image_angle
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

if !instance_exists(NothingSpiral) && !instance_exists(MainMenu) {
	if !active && (!scrGameIsGenerationScreen() && !instance_exists(Credits)) {
		instance_destroy()
	}
}