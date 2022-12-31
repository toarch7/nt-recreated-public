global.log_output = []
global.log_color = []

global.console_active = 0

function scrContentIdByName(name, arr) {
    var i = -1

    if is_array(name) name = array_join(name, " ")

    try {
        if real(name) {
            return real(name)
        }
    } catch (e) {}

    if i == -1 {
        name = string_upper(name)

        for (var i = 0; i < array_length(arr); i++) {
            if name == arr[i]
            return i
        }

        return -1
    }

    return -1
}

function scrParseSpawn(cmd) {
    var keys = variable_global_exists("_console_instance_names") ? variable_global_get("_console_instance_names") : -1

    if keys == -1 {
        keys = {}

        for (var i = 0; object_exists(i); i++) {
            keys[$ string_lower(object_get_name(i))] = i
        }

        keys[$ "bigdog"] = ScrapBoss
        keys[$ "throne"] = Nothing
        keys[$ "captain"] = Last
        keys[$ "bigbandit"] = BanditBoss

        variable_global_set("_console_instance_names", keys)
    }

    var name = ""

    for (var i = 1; i < array_length(cmd); i++) {
        // bruh :kms:
        try {
            if real(cmd[i]) break
        } catch (e) {
            name += cmd[i]

            array_delete(cmd, 1, 1)
            i--
        }
    }

    return keys[$ string_lower(name)]
}

function string_split_array(str, delimiter) {
    var r = []
    var l = string_length(str)
    var p = 1
    var v = ""

    while p <= l {
        var c = string_char_at(str, p++)

        if c == delimiter {
            array_push(r, v) v = ""
            continue
        }

        v += c
    }

    array_push(r, v)

    return r
}