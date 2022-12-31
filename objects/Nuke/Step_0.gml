if active {
    with instance_create(x, y, Smoke) {
        depth = other.depth + 1
    }

    if speed > 5 speed = 5

    if instance_exists(creator) {
        motion_add(creator.gunangle, 0.5)
    }

    motion_add(direction, 0.5)

    if BackCont.shake < 3 BackCont.shake = 3
}

image_angle = direction