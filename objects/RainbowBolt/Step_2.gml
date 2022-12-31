with(instance_create(x, y, BoltTrail)) {
    image_angle = point_direction(other.x, other.y, other.xprevious, other.yprevious)
    image_xscale = point_distance(other.x, other.y, other.xprevious, other.yprevious)
    image_blend = make_colour_hsv(other.col, 255, 255)
}