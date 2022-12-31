friction = 0.4
image_index = 1

repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(2))
}