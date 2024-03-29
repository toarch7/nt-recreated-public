function scrLanguageSet(_lang) {
    if _lang == "null" or is_undefined(localizations_list[$ _lang]) or !is_string(_lang) {
        _lang = os_get_language()
		
        if is_undefined(localizations_list[$ _lang])
            _lang = "en"
		
		with UberCont {
	        save_set_value("etc", "language", _lang)
	        opt_language = _lang
	    }
	}
	
    global.localization_current = localizations_list[$ _lang]
	
    if is_undefined(global.localization_current) {
        print_error("Failed to set language " + _lang, 1)
        global.localization_current = {}
    }
	else print($"Language set to `{_lang}`")
}