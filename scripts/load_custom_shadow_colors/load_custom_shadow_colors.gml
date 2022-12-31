function load_custom_shadow_colors(path) {
    var status = 0

    try {
        var data = json_parse(file_read(path))
        var keys = struct_keys(data)

        for (var i = 0; i < array_length(keys); i++) {
            global.customshadowcolors[$ keys[i]] = data[$ keys[i]]
        }
    } catch (e) {
        printc("[!!!] Failed to load custom background colors: " + e.message, c_red)
        status = 1
    }

    return status
}