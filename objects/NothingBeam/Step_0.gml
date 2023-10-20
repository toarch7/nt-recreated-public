if lockstep_stop
	exit

var ang, dst;

if !instance_exists(creator) {
    instance_destroy()
    exit
}

x = creator.x
y = creator.y + 48

if charge {
    with instance_create(x, y - 16, NothingBeamChargeParticle) {
        ang = random_angle
        dst = 16 + random(64)
        x += lengthdir_x(dst, ang)
        y += lengthdir_y(dst, ang)
        motion_add(point_direction(x, y, xstart, ystart), point_distance(x, y, xstart, ystart) / 20)
        image_angle = direction
    }
} else {
    image_yscale = 1

    iter = 0
    while !place_meeting(x, y, Wall) {
        image_yscale--
        if iter > 1000 {
            break
        }
    }

    instance_create(x + orandom(20), y + orandom(1) + image_yscale, NothingBeamHit)

    if BackCont.shake < 3 {
        BackCont.shake = 3
    }

    if !disappear {
        with instance_create(x + orandom(20), creator.y + 48 + random(24), NothingBeamParticle) {
            vspeed = 12 + random(10)
            image_angle = direction
        }
    }
}