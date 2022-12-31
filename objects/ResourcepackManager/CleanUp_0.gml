for (var i = 0; i < array_length(icons); i++) {
    sprite_delete(icons[i])
}

ds_map_destroy(headermap)

directory_destroy_recursive("_temp")

if restart {
    discard_custom_sounds()
    discard_custom_sprites()

    snd_play(sndRestart)

    load_resourcepacks()
}