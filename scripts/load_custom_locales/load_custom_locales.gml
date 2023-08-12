function load_custom_locales(path) {
    var status = 0

    with UberCont {
        var list = []

        var f = file_find_first(path + "*.loc", 0)

        while f != "" {
            array_push(list, f)
            f = file_find_next()
        }

        file_find_close()

        for (var i = 0; i < array_length(list); i++) {
            var p = path + list[i]

            try {
                var data = json_parse(file_read(p))
                var name = string_replace(list[i], ".loc", "")
                var l = localizations_list[$ name]

                if l != undefined {
                    var keys = struct_keys(data)

                    for (var i = 0; i < array_length(keys); i++) {
                        l[$ keys[i]] = data[$ keys[i]]
                    }
                } else {
                    localizations_list[$ name] = data
                }
            } catch (e) {
                printc("[!!!] Failed to load localization \"" + p + "\" " + e.message, c_red)
                status = 1
            }
        }
    }

    return status
}