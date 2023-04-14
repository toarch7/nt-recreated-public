function scrLoadLocalizations() {
    var p = "localizations/",
		_find = file_find_first(p + "*.loc", 0),
		failed = ""

    while _find != "" {
        if _find == "default" {
			_find = file_find_next()
			
			continue
		}
		
		var _file = file_text_open_read(p + _find),
			_data = ""
		
        while !file_text_eof(_file) {
            _data += file_text_read_string(_file)
            file_text_readln(_file)
        }

        try {
            AllLocales[$ string_replace(_find, ".loc", "")] = json_parse(_data);
        }
		catch (e) {
            show_debug_message([_find, e.message])
        }

        file_text_close(_file)

        _find = file_find_next()
    }

    file_find_close()
}