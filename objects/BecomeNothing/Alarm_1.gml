with MusCont {
    alarm[2] = 1
}

image_index += 1
alarm[6] = 90
BackCont.shake += 7

repeat 20 {
    with instance_create(x + (random(32) - 16), y + (random(32) - 16) + 50, Debris) {
        motion_add(200 + random(140), 5 + random(4))
        instance_create(x + hspeed, y + vspeed, Smoke)
    }
}