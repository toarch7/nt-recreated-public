friction = 0.4


repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(2))
}

if sticky = 1 depth = -3