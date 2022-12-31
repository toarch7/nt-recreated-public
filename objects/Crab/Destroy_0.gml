scrDrop(30, 0)

event_inherited()

dir = random(360)

repeat 3 {
    with instance_create(x, y, AcidStreak) {
        motion_add(other.dir, 8)
        image_angle = direction
    }

    dir += 120
}