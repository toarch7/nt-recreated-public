if lockstep_stop
	exit

if friction > 0.15 {
    with instance_create(x, y, Flame) {
        motion_add(other.direction + random(20) - 10, random(1))
        team = other.team
    }
}