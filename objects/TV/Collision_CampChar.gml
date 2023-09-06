if lockstep_stop
	exit

if other.race == 15 {
    with other {
        motion_add(point_direction(other.x, other.y, x, y), 1)

        if speed > 8 {
            speed = 8
        }
    }

    exit
}

if stuck > 10 exit;
stuck++

x += lengthdir_x(2, point_direction(other.x, other.y, x, y))
y += lengthdir_y(2, point_direction(other.x, other.y, x, y))