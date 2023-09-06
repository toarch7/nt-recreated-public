if lockstep_stop
	exit

if other.object_index == object_index && id < other.id {
    var d = point_direction(other.x, other.y, x, y) + orandom(1)
    var xx = lengthdir_x(8, d),
        yy = lengthdir_y(8, d)

        if !place_meeting(x + xx, y, Wall) x += xx

    if !place_meeting(x, y + yy, Wall) y += yy
}