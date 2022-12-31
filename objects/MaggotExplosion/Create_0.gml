spawned = 0
image_speed = 0.4
alarm[0] = 2


dir = random(360)
repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(other.dir, 4 + random(1))
    dir += 360 / 6
}
dir = random(360)
repeat(3) {
    with instance_create(x, y, BloodStreak) {
        motion_add(other.dir, 8)
        image_angle = direction
    }
    dir += 120
}