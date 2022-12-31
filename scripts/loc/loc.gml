function loc(_key) {
    return !is_undefined(global.Locales[$ _key]) ? global.Locales[$ _key] : _key
}