if lockstep_stop
	exit

with(instance_create(x, y, BoltTrail)) {
    image_angle = point_direction(other.x, other.y, other.xprevious, other.yprevious)
    image_xscale = point_distance(other.x, other.y, other.xprevious, other.yprevious)
    image_yscale = .8
}