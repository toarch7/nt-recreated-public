if type == 2 {
    image_angle += 10 + sin(image_angle / 300) * 2 + random(1)
}
else {
    image_angle += 8 + sin(image_angle / 300) * 1
}

time++

x = room_width / 2 + sin(image_angle / 921) * sin(image_angle / 500) * 80
y = room_height / 2 + cos(image_angle / 583) * sin(image_angle / 500) * 50

if type == 4 or type == 3 {
    x = view_width / 2
    y = view_height / 2
}

if random(12) < 1 && type != 4 {
    if (type == 2 or(random(3) < 1)) && !bossfight {
        with instance_create(x, y, SpiralDebris) {
            depth = other.image_angle
        }
    }
}


if type != 4 {
    with instance_create(x, y, Spiral) {
        image_xscale = 0
        image_yscale = 0

        depth = other.image_angle
        image_angle = other.image_angle
		
        if other.type == 3 {
            sprite_index = sprSpiralIDPD

            if other.time % 11 <= 1 {
                sprite_index = sprSpiralIDPD2
            }

            x = room_width / 2
            y = room_height / 2
        }

        if other.type == 2 {
            image_xscale = random(0.01)
            image_yscale = random(0.01)
            sprite_index = sprSpiralProto
            image_angle = other.image_angle
        }
    }
}
else instance_create(x, y, SpiralStar)

if (area == 0 && !instance_exists(NothingSpiral)) or area != 0 {
    if !instance_exists(LevCont) && !instance_exists(GenCont) && !instance_exists(SitDown) && instance_exists(BackCont) && !instance_exists(Credits) && active {
        print("selfdestroyed", id)
		instance_destroy()
    }
}