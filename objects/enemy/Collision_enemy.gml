if size <= other.size motion_add(point_direction(other.x + random_spread(1), other.y + random_spread(1), x, y), 1)

//cap speed
if speed > 16 speed = 16