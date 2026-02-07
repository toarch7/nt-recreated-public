if lockstep_stop
	exit

if GameCont.area == area_palace && GameCont.subarea == GameCont.maxsubarea {
    styleb = 0

    with GenCont {
        alarm[0] = 3
        alarm[2] = 2
    }
	
    dix = -4
    diy = 0

    repeat 48 {
        repeat 8 {
            if !((dix == -4 || dix == 3) && diy < -43) {
                instance_create(x + dix * 32 + 16, y + diy * 32, Floor)
            }

            dix += 1
        }

        dix = -4
        diy -= 1

        if round(diy / 5) == diy / 5 && -diy > 9 && -diy < 34 {
            instance_create(x - 96 + 16, y + diy * 32 - 96 + 64, ThroneStatue)
            instance_create(x + 96 + 16, y + diy * 32 - 96 + 64, ThroneStatue)
        }
    }

    with instance_create(x + 160 + 16, y + diy * 32 + 384 + 160 + 64, BigGeneratorInactive) {
        image_xscale = -1
    }

    with instance_create(x - 160 + 16, y + diy * 32 + 384 + 160 + 64, BigGeneratorInactive) {
        image_xscale = 1
    }

    instance_create(x + 16, y + diy * 32 + 128, NothingInactive)

    with instance_create(x + 160 + 16, y + diy * 32 + 384 + 64, BigGeneratorInactive) {
        image_xscale = -1
    }

    with instance_create(x - 160 + 16, y + diy * 32 + 384 + 64, BigGeneratorInactive) {
        image_xscale = 1
    }
	
	with (BigGeneratorInactive) {
		for(var yy = 0; yy <= 2; yy ++) {
			var _py = ((bbox_top div 32) + yy) * 32
			
			for(var xx = 0; xx <= 1; xx ++) {
				var _px = ((x div 32) + xx - 1) * 32
				instance_create(_px, _py, Floor)
			}
		}
		y -= 16
		yprevious = y
		ystart = y
	}

    instance_destroy()
    exit
}

if instance_number(Floor) > goal {
    if point_distance(x, y, 10016, 10016) > 48 {
        instance_create(x, y, Floor)

        if !instance_exists(MenuGen) {
            instance_create(x + 16, y + 16, RadChest)
        }
    }

    instance_destroy()
} else {
    scrMakeFloor()

    with GenCont
    alarm[0] = 3

    with GenCont
    alarm[2] = 2
}