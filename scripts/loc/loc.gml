function loc(_key) {
    return !is_undefined(global.localization_current[$ _key]) ? global.localization_current[$ _key] : _key
}