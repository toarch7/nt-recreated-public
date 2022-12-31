image_speed = 0

with ToxicBarrel {
    if point_distance(x, y, other.x, other.y) < 64 instance_change(Wind, false)
}