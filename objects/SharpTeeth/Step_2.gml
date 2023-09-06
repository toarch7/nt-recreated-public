if lockstep_stop
	exit

if instance_exists(Player) && instance_exists(target) {
    x = target.x
    y = target.y
}