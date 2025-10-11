/// @function loc
/// @param localization_key
function loc(_key) {
    return global.language_current[$ string(_key)] ?? string(_key)
}

/// @function loc_ext
/// @param localization_key
/// @param [default=undefined]
function loc_ext(_key, _default) {
    return global.language_current[$ string(_key)] ?? _default
}