event_inherited()
if (sprite_index != spr_fire) motion_add(direction, 0.5)
if (speed > 1.5) speed = 1.5
if (explode == 1) {
    with(instance_create(x, y, LaserCharge)) {
        motion_add(random(360), (2 + random(1)))
        alarm[0] = (10 + random(10))
    }
}
if (alarm[2] > 8) {
    with(instance_create(((x + random(96)) - 48), ((y + random(96)) - 48), LaserCharge)) {
        motion_add(point_direction(x, y, other.x, other.y), (2 + random(1)))
        alarm[0] = ((point_distance(x, y, other.x, other.y) / speed) + 1)
    }
    repeat(2) {
        with(instance_create(((x + random(6)) - 3), ((y + random(6)) - 3), LaserCharge)) {
            move_contact_solid(other.gunangle, random(480))
            motion_add(random(360), (2 + random(1)))
            alarm[0] = (2 + random(4))
        }
    }
}