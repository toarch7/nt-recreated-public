if instance_exists(GenCont) {
    instance_destroy(id);
    exit
}

image_angle = random_angle

motion_add(random_angle, random(1) + 0.5)

friction = 0.1
image_speed = 0
image_index = random(5)

image_xscale = 0.8
image_yscale = 0.8
rot = (1 + random(3)) * choose(1, - 1)
growspeed = random(0.01) / 2

if UberCont.opt_prtcls {
    instance_destroy(); exit
}
