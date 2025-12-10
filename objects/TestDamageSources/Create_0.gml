event_inherited()

scrRunStart()

list = array_filter(asset_get_ids(asset_object), function(_object) {
	return object_is_ancestor(_object, damagesource)
})

reset = function() {
	duration = 0
	projectile_created = false
	scr_test_create_arena()
}