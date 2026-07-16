function discard_custom_sounds() {
    var keys = struct_keys(global.custom_sounds)

    for (var i = 0; i < array_length(keys); i++) {
        audio_destroy_stream(global.custom_sounds[$ keys[i]])
    }

    global.custom_sounds = {}
}