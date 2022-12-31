function custom_sound_check(snd) {
    var s = variable_struct_get(global.customSounds, string(snd))

    if s == undefined
    return snd

    return s
}