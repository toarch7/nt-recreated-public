if lockstep_stop
	exit

if instance_is(other, MaggotSpawn) && id < other.id {
    var _direction = point_direction(
			other.x + orandom(1), other.y + orandom(1), x, y),
		
		_mx = lengthdir_x(8, _direction),
        _my = lengthdir_y(8, _direction)
	
    if place_free(x + _mx, y) x += _mx
	if place_free(x, y + _my) y += _my
}