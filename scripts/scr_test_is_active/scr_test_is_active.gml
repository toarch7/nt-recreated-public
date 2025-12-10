function scr_test_is_active() {
	return instance_exists(TestCont)
}

function scr_test_is_fps_uncapped() {
	return (game_speed >= game_speed_uncaped)
}

/// @function scr_test_create_arena
/// @param size=5
function scr_test_create_arena(_size = 5) {
	scrCleanupAreaInstances()
	
	with Player {
		x = 10016
		y = 10016
		
		var _x = 10000, _y = 10000
		for(var yy = -_size; yy < _size; ++yy) {
			for(var xx = -_size; xx < _size; ++xx) {
				instance_create(_x + xx * 32, _y + yy * 32, Floor)
			}
		}
		
		with (Floor) mcr_floor_make_walls;
		with (Floor) mcr_floor_create_tops;
		
		for(var i = 0; i < 360; i += 10) {
			var _n = 24 + ((i % 90) / 90) * 64
			instance_create(x + ldrx(_n, i), y + ldry(_n, i), Dummy)
		}
	}
}