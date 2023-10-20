event_inherited()


if sprite_index != spr_fire motion_add(direction, 0.5)

if speed > 1.5 speed = 1.5

if alarm[2] > 8 {
    with instance_create(x + random(96) - 48, y + random(96) - 48, LaserCharge) {
        motion_add(point_direction(x, y, other.x, other.y), 2 + random(1))
        alarm[0] = point_distance(x, y, other.x, other.y) / speed + 1
    }
    with instance_create(x + random(6) - 3, y + random(6) - 3, LaserCharge) {
        move_contact_solid(other.gunangle, random(480))
        motion_add(random_angle, 2 + random(1))
        alarm[0] = 2 + random(4)
    }
}

if irandom(3) instance_create(x + random_range(-8, 8), y + random_range(-12, 12), Curse)