scrDrop(15, 0)

event_inherited()

var _ang = random_angle

repeat (3) {
    with instance_create(x, y, AcidStreak) {
        motion_add(_ang, 8)
        image_angle = direction
    }
    _ang += 120
}