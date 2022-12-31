move_bounce_solid(00)

with instance_create(x, y, Maggot) {
    motion_add(point_direction(other.x, other.y, x, y), 4)
    givekill = 0
}

instance_destroy(id, 0)