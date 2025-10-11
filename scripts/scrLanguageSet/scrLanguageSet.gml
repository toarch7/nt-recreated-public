function scrLanguageSet(_lang) {
    if _lang == "null" or is_undefined(global.language_list[$ _lang]) or !is_string(_lang) {
        _lang = os_get_language()
		
        if is_undefined(global.language_list[$ _lang])
            _lang = "en"
		
		with UberCont {
	        save_set_value("etc", "language", _lang)
	        opt_language = _lang
	    }
	}
	
    global.language_current = global.language_list[$ _lang]
	
    if is_undefined(global.language_current) {
        print_error("Failed to set language " + _lang, 1)
        global.language_current = {}
    }
	else print($"Language set to `{_lang}`")
}