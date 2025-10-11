if sprite_exists(pausespr) {
	sprite_delete(pausespr)
}

discard_custom_sounds()
discard_custom_sprites()

if ds_exists(volqueue, ds_type_queue) {
	ds_queue_destroy(volqueue)
}

resourcepack_temp_cleanup()

scrBignameSurfaceCleanup()

if native_cursor_inst != -1 {
	native_cursor_destroy(native_cursor_inst)
}