with(instance_create(x, y, BoltTrail)) {
    image_angle = point_direction(other.x, other.y, other.xprevious, other.yprevious)
    image_xscale = point_distance(other.x, other.y, other.xprevious, other.yprevious)
    sprite_index = sprUltraBoltTrail
    image_yscale = 1.2
}