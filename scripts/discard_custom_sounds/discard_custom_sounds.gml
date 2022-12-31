function discard_custom_sounds() {
    var keys = struct_keys(global.customSounds)

    for (var i = 0; i < array_length(keys); i++) {
        audio_destroy_stream(global.customSounds[$ keys[i]])
    }

    global.customSounds = {}
}