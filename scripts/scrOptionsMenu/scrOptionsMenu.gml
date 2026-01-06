function scrOptionsMenuCategoryBegin(num) {
	if option_number != -1
		scrOptionsMenuCategoryEnd()
	
	option_list = []
	option_number = num
}

function scrOptionsMenuCategoryEnd() {
	if option_number == -1
		exit
	
	options[option_number] = option_list
	
	option_list = undefined
	option_number = -1
}

function scrOptionsMenuCreateElement(_opt, _to_current_category = false) {
	with MenuOptions {
		if option_list == undefined && !_to_current_category exit
		
		if !debug {
			if _opt[$ "desktop_only"] && !is_desktop exit
			if _opt[$ "mobile_only"] && is_desktop exit
		}
		
		if _opt[$ "ingame"] != undefined && _opt.ingame != ingame {
			if option_number != OptionCategory.Main exit
			
			_opt[$ "available"] = false
			_opt[$ "condition"] = undefined
		}
		
		_opt[$ "type"] ??= "button"
		_opt[$ "name"] ??= "BUTTON"
		_opt[$ "visible"] ??= true
		_opt[$ "available"] ??= true
		_opt[$ "skip"] ??= false
		
		_opt[$ "value"] ??= undefined
		_opt[$ "category"] ??= undefined
		
		if _opt.type == "switch" {
			_opt[$ "states"] ??= [ OPTION_OFF, OPTION_ON ]
		}
		
		if _opt.type == "input" {
			_opt[$ "previous"] = undefined
			_opt[$ "validate"] ??= undefined
		}
		
		_opt[$ "draw"] ??= undefined
		_opt[$ "click"] ??= undefined
		_opt[$ "get_name"] ??= undefined
		_opt[$ "get_value"] ??= undefined
		_opt[$ "condition"] ??= undefined
		_opt[$ "sprite"] ??= undefined
		_opt[$ "key"] ??= undefined
		_opt[$ "width"] ??= 260
		_opt[$ "height"] ??= font_get_string_height(string_hash_to_newline(_opt.name))
		_opt[$ "anim"] = 0
		_opt[$ "splat"] = 0
		
		var _newlines = string_count("\n", string_hash_to_newline(_opt.name))
		if (_newlines > 0) _opt.height += 5
		
		if _opt.type == "category" || is_undefined(_opt.key) {
			_opt[$ "halign"] ??= fa_center
		}
		else {
			_opt[$ "halign"] ??= fa_left
		}
		_opt[$ "valign"] ??= fa_center
		
		//
		if _opt.type == "list" {
			_opt[$ "list"] ??= []
			_opt.list_kind = "numeric"
			
			for(var i = 0; i < array_length(_opt.list); i ++) {
				if !is_numeric(_opt.list[i]) {
					_opt.list_kind = "collection"; break
				}
			}
		}
		
		_opt.has_value = method(_opt, function() {
			if (is_method(self[$ "get_value"]) || type == "keybind") {
				return true
			}
			
			if ((type == "category" || type == "button") && value != "") {
				return false
			}
			
			return (value != "")
		})
		
		if !is_undefined(_opt.sprite) {
			_opt.height = max(_opt.height, sprite_get_height(_opt.sprite[0]))
		}
		
		if _opt.key != undefined && _opt.value == undefined {
			_opt.value = UberCont.saveData[? _opt.key]
		}
		
		if (!_opt.has_value()) _opt.width *= 0.5
		
		if (_to_current_category) {
			array_push(options[category], _opt)
		}
		else {
			array_push(option_list, _opt)
		}
	}
}

function scrOptionsMenuCreateElements() {
	for(var i = 0; i < argument_count; i ++) {
		if is_struct(argument[i]) {
			scrOptionsMenuCreateElement(argument[i])
		}
	}
}

function scrOptionsMenuRemoveLocalGames() {
	with MenuOptions {
		var _list = options[category],
			_any = false
		
		for(var i = 0; i < array_length(_list); i ++) {
			var _opt = _list[i]
		
			if _opt[$ "__multiplayer_game"] {
				array_delete(_list, i, 1)
				_any = true
			}
		}
		
		options[category] = _list
	}
}

/// @function scrOptionsMenuChangeCategory
/// @param {Enum.OptionCategory} category
/// @param store_in_history=true
function scrOptionsMenuChangeCategory(_category, _queue = true) {
	with MenuOptions {
		if _category >= array_length(options) {
			print($"Can't change category to {_category}, number exceeds max amount of defined categories ({array_length(options)})")
			exit
		}
		
		if category != _category && _queue {
			ds_stack_push(category_stack, category)
		}
		
		category = _category
		
		var _options = options[_category],
			_option_count = array_length(_options)
		
		items = []
		scroll_check = true
		last_change = current_frame + 3
		pointed_item = -1
		item_count = 0
		
		for(var i = 0; i < _option_count; i ++) {
			var _opt = _options[i]
			
			_opt.appear = 0
			
			if _opt[$ "awake"] != undefined {
				method_execute(_opt.awake, _opt)
			}
			
			if _opt.type == "keybind" {
				if _opt.condition != undefined {
					_opt.available = method_execute(_opt.condition, _opt)
				}
				
				_opt.visible = _opt.available
			}
			
			if _opt.visible {
				array_push(items, _opt)
				item_count ++
			}
		}
		
		draw_step_size = 8 + font_get_string_height("Aa")
		
		if (item_count >= 12) {
			draw_step_size = floor(draw_step_size * 0.85)
		}
		
		if !is_desktop {
			mousex = -1000
			mousey = -1000
		}
		
		snd_play(_category == OptionCategory.Main ? sndMenuOptions : sndClick)
	}
}