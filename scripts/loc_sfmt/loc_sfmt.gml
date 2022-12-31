function loc_sfmt() {
    var _key = argument[0]
    var _result = !is_undefined(global.Locales[$ _key]) ? global.Locales[$ _key] : _key

    for (var i = 1; i < argument_count; i++) {
        _result = string_replace(_result, "%", string(argument[i]))
    }

    return _result
}