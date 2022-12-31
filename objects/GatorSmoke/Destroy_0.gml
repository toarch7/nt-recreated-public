givekill = 1
do {
    if raddrop > 15 {
        raddrop -= 10
        with instance_create(x, y, BigRad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(other.raddrop / 2) + 2)
            repeat(speed)
            speed *= 0.9
        }
    }
}
until raddrop <= 15

repeat(raddrop) {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(other.raddrop / 2) + 2)
        repeat(speed)
        speed *= 0.9
    }
}

event_inherited()