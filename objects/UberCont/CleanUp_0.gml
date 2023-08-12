if pausespr {
    sprite_delete(pausespr)
}

ds_queue_destroy(global.inputqueue)

discard_custom_sounds()
discard_custom_sprites()

if volqueue != -1 ds_queue_destroy(volqueue)

resourcepack_temp_cleanup()

scrBignameSurfaceCleanup()
