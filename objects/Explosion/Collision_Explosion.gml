if lockstep_stop
	exit

with Wall
if place_meeting(x, y, other) {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}

if other.object_index == Explosion or other.object_index == GreenExplosion {
    x += lengthdir_x(6, point_direction(other.x, other.y, x, y))
    y += lengthdir_y(6, point_direction(other.x, other.y, x, y))
} else if other.object_index == SmallExplosion {
    x += lengthdir_x(1, point_direction(other.x, other.y, x, y))
    y += lengthdir_y(1, point_direction(other.x, other.y, x, y))
}