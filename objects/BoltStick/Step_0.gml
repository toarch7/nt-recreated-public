if lockstep_stop
	exit

if instance_exists(target) {
    z = 0

    if target.object_index == LilHunterFly or target.object_index == RavenFly {
        instance_destroy()
        exit
    }

    x = target.x
    y = target.y - z
    visible = target.visible
} else instance_destroy()