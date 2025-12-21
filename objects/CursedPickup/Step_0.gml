if lockstep_stop
	exit

if image_index < 1 {
	image_index += timescale * random(0.04)
}
else image_index += timescale * 0.4

if current_frame_active && random(4) < 1 {
    with instance_create(x, y, Curse) {
		depth = other.depth + 1
        hspeed = orandom(1)
    }
}
