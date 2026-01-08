#macro language_default "English"

global.language_font_default = fntM1

global.language_font_bigname_loaded = false
global.language_font_bigname_default = fntBig

global.language_font_cjk = -1
global.language_font_noto = -1
global.language_font_bigname_cyrillic = -1

function scrLanguagesInit() {
	global.language_store = {}
	global.language_current = {}
	global.language_sprites = []
	global.language_list = []
	
	global.language_store[$ language_default] = {}
	
	scrLanguageTryLoadTTFs()
}

function scrLanguageTryLoadTTFs() {
	font_add_enable_aa(false)
	
	if (!font_exists(global.language_font_cjk)) {
		var _f = font_add(scrProjectPath("lang/Silver.ttf"), 14, false, false, 0x21, 0x9FFF)
		global.language_font_cjk = _f
	}
	
	if (!font_exists(global.language_font_noto)) {
		var _f = font_add(scrProjectPath("lang/Noto-Sans-CJK-Bold.otf"), 26, false, false, 0x21, 0x9FFF)
		global.language_font_noto = _f
	}
	
	if (!global.language_font_bigname_loaded) {
		sprite_set_offset(sprBigNameFont, 0, 0)
		var _charset = " .ABCDEFGHIJKLMNOPQRSTUVWXYZ!:'/?¡¿ÁÀÄÂÃȦÆÇÉÈЁÊĞÍÌЇÎÑÓÒÖÔŒŞÚÙÜÛŸßİŚĄĆĘĞİŁŃŹŻ"
		font_replace_sprite_ext(fntBig, sprBigNameFont, _charset, true, 2)
		global.language_font_bigname_loaded = true
	}
	
	if (!font_exists(global.language_font_bigname_cyrillic)) {
		var _sprite = sprite_add(scrProjectPath("lang/BigNameFont_Cyrillic.png"), 35, false, false, 0, 0),
			_charset = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯЁІЇ",
			_f = font_add_sprite_ext(_sprite, _charset, true, -14)
		
		global.language_font_bigname_cyrillic = _f
	}
}

function scrLanguagesLoad() {
	array_foreach(global.language_sprites, function(_sprite) {
		if (sprite_exists(_sprite)) sprite_delete(_sprite)
	})
	
	scrLanguagesInit()
	
	var _lang_directory = scrProjectPath("lang/"),
		_lang_contents = array_union([ "lang.csv" ], directory_read(_lang_directory + "/*.csv", fa_none)),
		_csv_list = array_filter(_lang_contents, function(_filename) {
			return string_ends_with(_filename, ".csv")
		})
	
	print("CSVs found:", _csv_list)
	
	array_foreach(_csv_list, function(_filename, _csv_index) {
		var _filepath = scrProjectPath("lang/" + _filename)
		
		if (!file_exists(_filepath)) {
			print_error($"{_filepath} table not found!")
			exit
		}
		
		var _t = get_timer(), _lang_csv = -1, _lang_csvx = -1;
		
		try {
			var _loadng_table = _filepath
			_lang_csv = load_csv(_loadng_table)
			
			_loadng_table = _filepath + "x"
			_lang_csvx = load_csv(_loadng_table)
		}
		catch(e) {
			print_exception($"Failed to load language table {_loadng_table}!", e)
			exit
		}
		
		var _language_begin = 0,
			_w = ds_grid_width(_lang_csv),
			_h = ds_grid_height(_lang_csv),
			_text_graph_found = false,
			_language_list = []
		
		//
		print("Loading languages from", _filepath, $"{_w}x{_h}")
		
		for(var _col = 0; _col < _w; ++_col) {
			var _language_id = string_trim(string(_lang_csv[# _col, 0]))
			
			if (!string_length(_language_id)) {
				_lang_csv[# _col, 0] = ""
				continue
			}
			
			var _language_name = string_trim(string(_lang_csv[# _col, 1]))
			
			if (!_text_graph_found) {
				if (string_lower(_language_id) == "text") {
					_text_graph_found = true
					_language_id = language_default
					_language_name = language_default
					_language_begin = _col
				}
				else continue
			}
			
			if (!string_length(_language_name)) {
				_language_name = _language_id
				_lang_csv[# _col, 1] = _language_name
			}
			
			var _language_data = {
				"Init:Id": _language_id,
				"Init:Name": _language_name,
				"Init:LabelSprite": -1,
			}
			
			global.language_store[$ _language_id] = _language_data
			array_push(_language_list, _language_data)
		}
		
		if (!_text_graph_found) {
			_language_begin = 2
			print("No text graph was found. Setting initial column to default", _language_begin)
		}
		
		var _language_count = array_length(_language_list),
			_language_start_index = 0
		
		#region Tokens & Strings
		
		for(var _row = 3; _row < _h; ++_row) {
			var _group = _lang_csv[# 0, _row],
				_key = _lang_csv[# 1, _row]
			
			var _hash = variable_get_hash($"{_group}:{_key}")
			
			for(
				var _language_index = _language_start_index;
				_language_index < _language_count;
				++_language_index
			) {
				var _col = _language_begin + _language_index,
					_lang = _language_list[_language_index],
					_string = _lang_csv[# _col, _row]
				
				struct_set_from_hash(_lang, _hash,
					string_replace_all(_string, chr(160), " "))
			}
		}
		
		#endregion
		
		#region `Init` part of CSVX
		
		var _w = ds_grid_width(_lang_csvx),
			_h = ds_grid_height(_lang_csvx),
			_language_begin = 0
		
		for(var _col = _language_begin; _col < _w; ++_col) {
			var _value = _lang_csvx[# _col, 0]
			
			if (is_string(_value) && string_lower(_value) == "text") {
				_lang_csvx[# _col, 0] = language_default
				_language_begin = _col
				break
			}
		}
		
		if (_language_begin == 0) {
			print("Couldn't find the Text graph for", _filepath + "x")
		}
		else for(var _row = 1; _row < _h; ++_row) {
			var _group = _lang_csvx[# 0, _row],
				_key = _lang_csvx[# 1, _row],
				_pair = $"{_group}:{_key}"
			
			for(var _language_index = 0; _language_index < _language_count; ++_language_index) {
				var _col = _language_begin + _language_index,
					_language_id = _lang_csvx[# _col, 0],
					_lang = _language_list[_language_index],
					_value = _lang_csvx[# _col, _row]
				
				// for whatever fucking reason in lang.csv it goes `Japanese -> Ukrainian -> Turikish`
				// but in lang.csvx it goes `Polish -> Ukrainian -> Russian` ??? alright I guess??
				// you'd say "but why not always only use global.language_store[$ _language_id]?"
				// but that's not gonna fucking works because in Dutch you have a different situaion
				// where the language id is set to Netherlands in lang_nl.csv and but in lang_nl.csvx
				// it's instead called Dutch so you can't use _language_id as the key
				if (_lang[$ "Init:Id"] != _language_id && variable_struct_exists(global.language_store, _language_id)) {
					_lang = global.language_store[$ _language_id]
				}
				
				if (_language_index != 0 && (is_undefined(_value) || string_length(_value) == 0)) {
					_value = _language_list[0][$ _pair]
					if (is_string(_value) && string_length(_value) == 0) {
						_value = undefined
					}
				}
				
				variable_struct_set(_lang, _pair, scr_string_try_parse_const(_value))
			}
		}
		
		#endregion
		
		array_foreach(_language_list, function(_lang) {
			if (GM_build_type == "run") {
				if (is_struct(_lang)) file_write("languages/" + _lang[$ "Init:Id"] + ".json", json_stringify(_lang, true))
			}
			
			scrLanguageProcess(_lang)
		})
		
		if (ds_exists(_lang_csv, ds_type_grid)) ds_grid_destroy(_lang_csv)
		if (ds_exists(_lang_csvx, ds_type_grid)) ds_grid_destroy(_lang_csvx)
	})
	
	draw_reset_font()
}

/// @function scrLanguageParam
/// @param lang_or_id
/// @param param
function scrLanguageParam(_language_id, _param) {
	var _language_data = is_struct(_language_id)
			? _language_id : global.language_store[$ _language_id],
		
		_key = $"Init:{_param}"
	
	assert(is_struct(_language_data))
	
	return variable_struct_get(_language_data, _key)
}

function scrLanguageProcess(_language) {
	#region Check for a likenamed mobile .ini language file
	var _path = scrProjectPath($"lang_mobile/{scrLanguageParam(_language, "Id")}.ini")
	
	if (file_exists(_path)) {
		var _ini_contents = scrIniToJSON(_path)
		
		with (_language) struct_foreach(_ini_contents, function(_key, _value) {
			self[$ _key] = _value
		})
		
		scrJSONToIni(_ini_contents, "test/" + _language[$ "Init:Id"] + ".ini")
	}
	#endregion
	
	#region Load label path
	var _label_path = scrLanguageParam(_language, "NameSprite")
	
	if (is_string(_label_path) && string_length(_label_path)) {
		_label_path = scrProjectPath("lang/" + _label_path)
		
		if (file_exists(_label_path)) {
			var _xoffset = scr_string_try_parse_const(scrLanguageParam(_language, "NameSpriteX")),
				_yoffset = scr_string_try_parse_const(scrLanguageParam(_language, "NameSpriteY")),
			
			if (!is_numeric(_xoffset)) _xoffset = 0
			if (!is_numeric(_yoffset)) _yoffset = 0
			
			var _sprite = sprite_add(_label_path, 1, false, false, _xoffset, _yoffset)
			array_push(global.language_sprites, _sprite)
			_language[$ "Init:LabelSprite"] = _sprite
		}
	}
	#endregion
}

function scrLanguageGetSystemLangName() {
	var _language = string_lower(os_get_language()),
		_region = string_upper(os_get_region())
	
	switch (_language) {
		case "zh":
			if (_region == "HK" || _region == "MO" || _region == "TW") {
				return "Traditional Chinese"
			}
			return "Simplified Chinese"
		case "ar": return "Arabic"
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
		
        if (is_undefined(global.language_store[$ _lang])) {
            _lang = language_default
		}
		
		with UberCont {
	        save_set_value("etc", "language", _lang)
	        opt_language = _lang
	    }
	}
	
	var _l = global.language_store[$ _lang]
    global.language_current = _l
	
    if is_undefined(global.language_current) {
        print_error("Failed to set language " + _lang, 1)
		if (_lang != language_default) {
			scrLanguageSet(language_default)
		}
		exit
    }
	else {
		print($"Language set to `{_lang}`")
	}
	
	var _template = scrLanguageParam(_l, "Template")
	
	if (_template == "CJK") {
		global.language_font_default = global.language_font_cjk
		global.language_font_bigname_default = global.language_font_noto
	}
	else if (_template == "CYR") {
		global.language_font_default = fntM1
		global.language_font_bigname_default = global.language_font_bigname_cyrillic
	}
	else {
		global.language_font_default = fntM1
		global.language_font_bigname_default = fntBig
	}
	draw_reset_font()
}

function scrLanguageNamesGetAll() {
	var _languages = array_unique(struct_keys(global.language_store))
	
	array_sort(_languages, true)

	var _index = array_get_index(_languages, language_default)
	if (_index >= 0) array_delete(_languages, _index, 1)
	array_insert(_languages, 0, language_default)
	
	return _languages
}
