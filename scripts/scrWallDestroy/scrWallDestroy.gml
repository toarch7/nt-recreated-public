/// @function scrWallDestroy
/// @param wall_instance
function scrWallDestroy(_instance) {
	with _instance {
		debug_assert(instance_is(self, Wall))
		
		instance_destroy()
		
		return instance_create(x, y, FloorExplo)
	}
	
	return noone
}