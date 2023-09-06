if lockstep_stop
	exit

flor = instance_nearest(x, y, Floor)
if instance_exists(flor) {
    direction = point_direction(x, y, flor.x, flor.y)
    x += lengthdir_x(8, direction)
    y += lengthdir_y(8, direction)
}