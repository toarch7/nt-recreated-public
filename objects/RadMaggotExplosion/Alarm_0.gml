repeat(20) {
    with instance_create(x + random(8) - 4, y + random(8) - 4, RadMaggot)
    motion_add(random_angle, random(5))
}