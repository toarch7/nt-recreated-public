event_inherited()

ang = random(360)

repeat(10) {
    with instance_create(x, y, Dust)
    motion_add(other.ang, 3)
    ang += 36
}