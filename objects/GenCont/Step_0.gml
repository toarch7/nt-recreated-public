/// @description Safespawn creation

if (!safespawn || instance_exists(FloorMaker)) exit

var _numfloors = 0, _safedis = (GameCont.loops ? 96 : 64)

with (Floor) {
	if (distance_to_point(10016, 10016) <= _safedis) _numfloors ++
}

var _maxfloors = ceil((_safedis / 32) * 2.5)
if (_numfloors < _maxfloors) exit

alarm[0] = 3
alarm[2] = 2

var _mx = ldrx(32, safedir),
	_my = ldry(32, safedir)

with (Floor) {
	x += _mx
	y += _my
}

with (chestprop) {
	x += _mx
	y += _my
}

with (PizzaEntrance) {
	x += _mx
	y += _my
}

with (SnowFloor) {
	x += _mx
	y += _my
}

with (hitme) if (object_index != Player) {
	x += _mx
	y += _my
	xstart = x
	ystart = y
	xprevious = x
	yprevious = y
}

instance_create(10000, 10000, Floor)