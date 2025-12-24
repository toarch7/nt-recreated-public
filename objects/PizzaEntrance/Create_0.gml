image_speed = 0

with (prop) {
    if (point_distance(x, y, other.x, other.y) < 64) instance_destroy(id, false)
}