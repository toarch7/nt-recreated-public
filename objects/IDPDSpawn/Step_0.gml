if lockstep_stop
	exit

if sprite_index = sprIDPDPortalCharge {
    with instance_create(x + random(96) - 48, y + random(96) - 48, IDPDPortalCharge) {
        motion_add(point_direction(x, y, other.x, other.y), 2 + random(1))
        alarm[0] = point_distance(x, y, other.x, other.y) / speed + 1
    }
}