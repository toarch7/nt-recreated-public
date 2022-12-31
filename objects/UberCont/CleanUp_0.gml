if pausespr {
    sprite_delete(pausespr)
}

ds_queue_destroy(global.inputqueue)

discard_custom_sounds()
discard_custom_sprites()

if volqueue != -1 ds_queue_destroy(volqueue)

resourcepack_temp_cleanup()

var keys = struct_keys(BigNameSurfaces)

for (var i = 0; i < array_length(keys); i++) {
    var s = BigNameSurfaces[$ keys[i]]

    if surface_exists(s) {
        surface_free(s)
    }
}