if pausespr
    sprite_delete(pausespr)

discard_custom_sounds()
discard_custom_sprites()

if volqueue != -1 ds_queue_destroy(volqueue)

resourcepack_temp_cleanup()

scrBignameSurfaceCleanup()

if server != -1
	network_destroy(server)

if native_cursor_inst != -1
	native_cursor_destroy(native_cursor_inst)