/// @description scrIniToJSON(file)
/// @param file
function scrIniToJSON(argument0) {
    var _ini = argument0
    var _json_map = ds_map_create()

    var _file = file_text_open_read(_ini)

    var _header = ""
    var _value = ""

    while !file_text_eof(_file) {
        var _str = file_text_read_string(_file)
        var c = string_copy(_str, 1, 1)

        if c == "[" {
            _header = string_replace(string_replace(_str, "]", ""), "[", "")
        } else {
            if _header == "controlls"
            or _header == "achieves"
            or _header == "cwep"
            or _header == "cswep" {
                file_text_readln(_file)
                continue
            }

            var arr = string_split_list(_str, "=")

            if is_undefined(arr) {
                file_text_close(_file)
                return _json_map
            }

            _value = ""

            if (is_undefined(arr[| 1])) {
                file_text_close(_file)
                return undefined
            }

            if string_is_real(string_replace_all(arr[| 1], "\"", "")) {
                var _____ = string_replace(arr[| 1], ".000000", "")
                show_debug_message(_____)
                _value = scrReal(string_digits(_____))
            } else _value = string(string_replace_all(arr[| 1], "\"", ""))

            _json_map[? _header + "_" + arr[| 0]] = _value
        }

        file_text_readln(_file)
    }

    file_text_close(_file)

    return _json_map



}