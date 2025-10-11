event_inherited()

repeat(20) {
    with instance_create(x + random(8) - 4, y + random(16), SodaCan) {
        motion_add(random_angle, random(4) + 3)
    }
}