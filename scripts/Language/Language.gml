#macro language_default "English"

function scrLanguagesInit() {
	global.language_store = {}
	global.language_current = {}
	
	//
	global.language_store[$ language_default] = {}
}

scrLanguagesInit()

function scrLanguagesLoad() {
	scrLanguagesInit()
	
	var _csv_list = array_union([ "lang.csv" ], directory_read("lang/*.csv", fa_none))
	
	print("CSVs found:", _csv_list)
	
	array_foreach(_csv_list, function(_filename, _index) {
		var _filepath = "lang/" + _filename
		
		if (!file_exists(_filepath)) {
			print_error($"{_filepath} table not found!")
			exit
		}
		
		var _t = get_timer(), _lang_csv = -1;
		
		try {
			_lang_csv = load_csv(_filepath)
		}
		catch(e) {
			print_exception($"Failed to load language table {_filepath}!", e)
			exit
		}
		
		var _language_begin = 0,
			_w = ds_grid_width(_lang_csv),
			_h = ds_grid_height(_lang_csv),
			_language_list = array_create(_w, undefined),
			_text_graph_found = false
		
		print("Loading languages from", _filepath, $"{_w}x{_h}")
		
		for(var _col = 0; _col < _w; ++_col) {
			var _language_id = string_trim(string(_lang_csv[# _col, 0]))
			
			if (!string_length(_language_id)) {
				_lang_csv[# _col, 0] = ""
				continue
			}
			
			if (!_text_graph_found) {
				_language_begin ++
				if (string_lower(_language_id) == "text") {
					_text_graph_found = true
				}
				continue
			}
			
			var _language_name = string_trim(string(_lang_csv[# _col, 1]))
			
			if (!string_length(_language_name)) {
				_language_name = _language_id
				_lang_csv[# _col, 1] = _language_name
			}
			
			var _language_data = {
				"Init.Name": _language_name,
				"Init.Id": _language_id,
				"Init.IdAlt": string_replace_all(_language_id, " ", "-"),
				"Init.LabelSprite": -1,
			}
			
			var _label_path = $"lang/labels/{_language_data[$ "Init.IdAlt"]}.png"
			if (file_exists(_label_path)) {
				_language_data[$ "Init.LabelSprite"] = sprite_add(_label_path, 1, false, false, 0, 0)
			}
			
			var _language_index = _col - _language_begin
			_language_list[_language_index] = _language_data
			global.language_store[$ _language_id] = _language_data
		}
		
		if (!_text_graph_found) {
			_language_begin = 2
			print("No text graph was found. Setting initial column to default", _language_begin)
		}
		
		// skip over English in the first table
		if (_index == 0 && _lang_csv[# _language_begin, 0] == "English") _language_begin ++
		
		for(var _row = _language_begin; _row < _h; ++_row) {
			var _group = _lang_csv[# 0, _row],
				_key = _lang_csv[# 1, _row]
			
			var _hash = variable_get_hash($"{_group}:{_key}")
			
			for(var _col = _language_begin; _col < _w; ++_col) {
				var _lang = _language_list[_col - _language_begin]
				if (is_struct(_lang)) {
					struct_set_from_hash(_lang, _hash, _lang_csv[# _col, _row])
				}
			}
		}
		
		ds_grid_destroy(_lang_csv)
	})
}

function scrLanguageGetSystemLangName() {
	var _language = string_lower(os_get_language()),
		_region = string_upper(os_get_region())
	switch (_language) {
		case "ar": return "Arabic"
		case "zh":
			if (_region == "HK" || _region == "MO" || _region == "TW") {
				return "Traditional Chinese"
			}
			return "Simplified Chinese"
		case "da": return "Danish"
		case "en": return "English"
		case "fr": return "French"
		case "de": return "German"
		case "el": return "Greek"
		case "it": return "Italian"
		case "ja": return "Japanese"
		case "no": return "Norwegian"
		case "pl": return "Polish"
		case "pt": return "Brazilian Portuguese"
		case "ru": return "Russian"
		case "es": return "Spanish"
		case "sv": return "Swedish"
		case "tr": return "Turkish"
		case "nl": return "Dutch"
	}
	return _language
}

function scrLanguageSet(_lang) {
    if (_lang == "null" || is_undefined(global.language_store[$ _lang]) || !is_string(_lang)) {
        _lang = scrLanguageGetSystemLangName()
		
        if is_undefined(global.language_store[$ _lang]) {
            _lang = language_default
		}
		
		with UberCont {
	        save_set_value("etc", "language", _lang)
	        opt_language = _lang
	    }
	}
	
    global.language_current = global.language_store[$ _lang]
	
    if is_undefined(global.language_current) {
        print_error("Failed to set language " + _lang, 1)
        global.language_current = {}
    }
	else print($"Language set to `{_lang}`")
}