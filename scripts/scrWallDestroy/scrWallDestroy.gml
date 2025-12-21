/// @function scrWallDestroy
/// @param wall_instance
function scrWallDestroy(_instance) {
	if (!instance_exists(_instance)) exit
	
	with (_instance) {
		do {
			instance_destroy(_instance)
			instance_create(x, y, FloorExplo)
			
			_instance = collision_rectangle(
				bbox_left, bbox_top, bbox_right, bbox_bottom, Wall, false, true)
		}
		until (!instance_exists(_instance))
	}
}