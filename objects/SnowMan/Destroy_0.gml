repeat(3)
instance_create(x + random(8) - 4, y + random(8) - 4, Bandit)



event_inherited()

repeat(6) {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(3) + 2)
        repeat(speed)
        speed *= 0.9
    }
}