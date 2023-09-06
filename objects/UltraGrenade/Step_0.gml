if lockstep_stop
	exit

if attract {
    with hitme {
        if distance_to_object(other) <= 32 motion_add(point_direction(x, y, other.x, other.y), 2)
    }
}