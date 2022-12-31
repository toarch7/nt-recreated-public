if other.object_index == object_index {
    x += lengthdir_x(4, point_direction(other.x, other.y, x, y) + random_spread(1))
    y += lengthdir_y(4, point_direction(other.x, other.y, x, y) + random_spread(1))
}