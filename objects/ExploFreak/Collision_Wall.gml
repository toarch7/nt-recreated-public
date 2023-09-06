if lockstep_stop
	exit

event_inherited()

if instance_exists(target) {
    if point_distance(x, y, target.x, target.y) < 96 {
        snd_play(snd_mele)
        instance_destroy()
    }
}