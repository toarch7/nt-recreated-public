#macro OPTION_ON loc("Options:On", "ON")
#macro OPTION_OFF loc("Options:Off", "OFF")

scr_network_instance()

languages = scrLanguageNamesGetAll()

enum OptionCategory {
	Main,
	
	Audio,
	Video,
	Game,
	Controls,
	Language,
	Resourcepacks,
	Cheats,
	CustomMode,
	
	Video_Display,
	
	Game_Profile,
	Game_Color,
	Game_Data,
	
	Controls_Remapping,
	Controls_Remapping_Keys,
	Controls_Preferences,
	Controls_Experimental,
	
	Coop_Menu,
	
	CustomMode_Loadout,
	CustomMode_Generation,
	CustomMode_Difficulty,
	CustomMode_Other,
	CustomMode_Reset,
	CustomMode_WeaponSelector,
	CustomMode_SkillSelector,
	
	NUM_MENU_OPTIONS
}

if (!instance_exists(BackButton)) {
	instance_create(0, 0, BackButton)
}

resourcepack_disclaimer = false
erasing_progress = 0

back_pressed = false

sliderheld = 0
editing_mode = false

text_input_element = undefined
text_input_cursor = ""
text_input_timer = 0
text_input_shake = 0

await_input = 0
await_keybind = undefined

category = OptionCategory.Main
category_stack = ds_stack_create()

slider = undefined
slider_change = 0
slider_x = 0

pointed_item = 0
item_count = 0

mouse_active = true
mx_last = 0
my_last = 0

mousex = 0
mousey = 0

drawx = 0
drawy = 0
startdrawy = 0

draw_step_size = 16

option_width = 0
option_height = 0
option_selected = 0
option_can_change = true
option_list_max = 0

debris = noone

scroll = 0
scroll_min = 0
scroll_max = 0
scroll_check = false
scroll_speed = 0
dragging = false

wait = true
press = 0

disclaimer_pop = 0

options = []
option_list = undefined
option_number = -1
items = []

last_change = 0

//native_cursor_dll_status = dll_check("native_cursor")

debug = global.__debug_menu_options
ingame = instance_exists(GameCont)
default_viewx = view_xview
default_viewy = view_yview
depth = -9999

colorpicker_update_scales = function(_color) {
	var _r = color_get_red(_color),
		_g = color_get_green(_color),
		_b = color_get_blue(_color),
		
		_color_controls = options[OptionCategory.Game_Color]
	
	_color_controls[1].value = _r / 255
	_color_controls[2].value = _g / 255
	_color_controls[3].value = _b / 255
}

colorpicker_update_options = function(_color) {
	var _value = base_convert(real(_color), 10, 16)
	UberCont.saveData[? "options_color"] = _value
	scrOptionsUpdate()
}

draw_inline_switch = function(_opt) {
	draw_text_nt(drawx, drawy, _opt.name + ": " + _opt.states[_opt.value ?? 0])
	
	return true
}

// define options
event_user(10)

element_functions = {}

element_functions[$ "category"] = function(_opt) {
	instance_destroy(CustomModeMenu)
	scrOptionsMenuChangeCategory(_opt.category)
	wait = 1
}

element_functions[$ "switch"] = function(_opt) {
	_opt.value ^= 1
}

element_functions[$ "list"] = function(_opt) {
	var list = _opt.list,
		index = array_get_index(list, _opt.value)
	
	if index != -1 && array_length(list) > index + 1 {
		_opt.value = list[index + 1]
	}
	else _opt.value = list[0]
}

element_functions[$ "input"] = function(_opt) {
	var v = method_execute(_opt.get_value, _opt) ?? _opt.value
	
	_opt.previous = v
	keyboard_string = v
	
	text_input_element = _opt
	text_input_timer = 0
}

element_functions[$ "keybind"] = function(_opt) {
	text_input_timer = 0
	
	await_input = true
	await_keybind = _opt
	
	keyboard_lastkey = -1
	mouse_lastbutton = -1
}

// can be removed..?
foreach(options, function(_value) {
    for (var i = 0; i < array_length(_value); i++) {
        var v = _value[i]
		
		if is_method(v[$ "awake"])
			method_execute(v.awake, v)
    }
})

dispose_on_empty = false