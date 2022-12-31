function scrLanguageSet(_lang) {
    with UberCont {
        if _lang == "null"
        or is_undefined(AllLocales[$ _lang]) or!is_string(_lang) {
            _lang = os_get_language()

            if is_undefined(AllLocales[$ _lang]) {
                _lang = "en"
            }

            save_set_val("etc", "language", _lang)
            opt_language = _lang
        }

        global.Locales = AllLocales[$ _lang]

        if is_undefined(global.Locales) {
            print_error("Failed to set language " + _lang, 1)
            global.Locales = {}
        }
    }
}