if lockstep_stop
	exit

if instance_exists(target) {
    x = target.x + lengthdir_x(10, target.gunangle)
    y = target.y + lengthdir_y(10, target.gunangle)
}