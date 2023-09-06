if lockstep_stop
	exit

if team != other.team && other.hp > 0 {
    with instance_create(x, y, Maggot) {
        motion_add(point_direction(other.x, other.y, x, y), 4)
        givekill = 0
    }
}