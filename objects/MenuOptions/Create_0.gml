#macro UI_SLIDER_OFFSET 20
#macro SWITCH_STATE_ON "ON"
#macro SWITCH_STATE_OFF "OFF"

netindex_set()

languages = struct_keys(global.localizations_list)

enum OptionCategory {
	Main,
	
	Audio,
	Video,
	Game,
	Controls,
	Resourcepacks,
	Cheats,
	
	Video_Display,
	
	Game_Profile,
	Game_Color,
	Game_Data,
	
	Controls_Remapping,
	Controls_Remapping_Keys,
	Controls_Preferences,
	Controls_Experimental,
	
	Coop_Menu,
	
	NumOptions
}

if !instance_exists(BackButton)
	instance_create(0, 0, BackButton)

rp_warning = 0
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

category = 0
category_stack = ds_stack_create()

slider = undefined
slider_change = 0
slider_x = 0

pointed_item = 0
item_count = -1

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

wait = true
press = 0

disclaimer_pop = 0

options = []
option_list = undefined
option_number = -1

last_change = 0

native_cursor_dll = dll_check("native_cursor")

ingame = instance_exists(GameCont)
default_viewx = view_xview // o, the burden of legacy crutches
default_viewy = view_yview

depth = -9999

function option_category_begin(num) {
	if option_number != -1
		option_category_end()
	
	option_list = []
	option_number = num
}

function option_category_end() {
	if option_number == -1
		exit
	
	options[option_number] = option_list
	
	option_list = undefined
	option_number = -1
}

debug = GM_build_type == "run"

function option_element_create(params) {
	if option_list == undefined
		exit
	
	if debug {
		if params[$ "desktop_only"] && !global.desktop
			exit
		
		if params[$ "mobile_only"] && global.desktop
			exit
	}
	
	if params[$ "ingame"] != undefined && params.ingame != ingame {
		if option_number != OptionCategory.Main
			exit
		
		params[$ "available"] = false
		params[$ "condition"] = undefined
	}
	
	params[$ "type"] ??= "button"
	params[$ "name"] ??= "BUTTON"
	params[$ "visible"] ??= true
	params[$ "available"] ??= true
	params[$ "skip"] ??= false
	
	params[$ "value"] ??= undefined
	params[$ "category"] ??= undefined
	
	if params.type == "switch"
		params[$ "states"] ??= [ SWITCH_STATE_OFF, SWITCH_STATE_ON ]
	
	if params.type == "input" {
		params[$ "previous"] = undefined
		params[$ "validate"] ??= undefined
	}
	
	params[$ "draw"] ??= undefined
	params[$ "click"] ??= undefined
	params[$ "name_get"] ??= undefined
	params[$ "value_get"] ??= undefined
	params[$ "condition"] ??= undefined
	
	params[$ "sprite"] ??= undefined
	
	params[$ "key"] ??= undefined
	
	params[$ "width"] ??= 240
	params[$ "height"] ??= string_height(string_hash_to_newline(params.name))
	
	params[$ "anim"] = 0
	params[$ "splat"] = 0
	
	if params.type == "category" or is_undefined(params.key) {
		params[$ "halign"] ??= fa_center
	}
	
	params[$ "halign"] ??= fa_left
	params[$ "valign"] ??= fa_center
	
	if params.type == "list" {
		params[$ "list"] ??= []
		
		params.list_kind = "numeric"
		
		for(var i = 0; i < array_length(params.list); i ++) {
			if !is_numeric(params.list[i]) {
				params.list_kind = "collection"; break
			}
		}
	}
	
	if !is_undefined(params.sprite)
		params.height = max(params.height, sprite_get_height(params.sprite[0]))
	
	if params.key != undefined && params.value == undefined
		params.value = UberCont.saveData[? params.key]
	
	array_push(option_list, params)
}

function option_elements_create() {
	for(var i = 0; i < argument_count; i ++) {
		if !is_undefined(argument[i])
			option_element_create(argument[i])
	}
}

category_set = function (_category, _queue = true) {
	if _category >= array_length(options) {
		print("Can't change category to", _category, ", ID number exceeded", array_length(options))
		exit
	}
	
	if category != _category && _queue
		ds_stack_push(category_stack, category)
	
	category = _category
	
	var items = options[_category]
	
	last_change = global.time + 2
	pointed_item = -1
	item_count = -1
	
	for(var i = 0; i < array_length(items); i ++) {
		var item = items[i]
		
		item.appear = 0
		
		if item[$ "awake"] != undefined
			method_execute(item.awake, item)
		
		if item.type == "keybind" {
			if item.condition != undefined
				item.available = method_execute(item.condition, item)
			
			if !item.available {
				item.visible = false
			}
			else item.visible = true
		}
	}
	
	if !global.desktop {
		mousex = -1000
		mousey = -1000
	}
	
	snd_play(_category == OptionCategory.Main ? sndMenuOptions : sndClick)
}

category_get = function(_category) {
	if _category >= array_length(options)
		exit
	
	return options[_category]
}

colorpicker_update_scales = function(color) {
	var r = color_get_red(color),
		g = color_get_green(color),
		b = color_get_blue(color)
	
	var col = category_get(OptionCategory.Game_Color)
	
	col[1].value = r / 255
	col[2].value = g / 255
	col[3].value = b / 255
}

colorpicker_update_options = function(color) {
	var val = base_convert(real(color), 10, 16)
	
	UberCont.saveData[? "options_color"] = val
	
	scrOptionsUpdate()
}

draw_inline_switch = function(opt) {
	draw_text_nt(drawx, drawy, loc(opt.name) + ": " + loc(opt.states[opt.value ?? 0]))
	
	return true
}

#region define categories

#region Main

option_category_begin(OptionCategory.Main)

option_elements_create
(
	{ type: "category", name: "AUDIO",    category: OptionCategory.Audio,    sprite: [ sprOptionButtons, 0 ] },
	{ type: "category", name: "VIDEO",    category: OptionCategory.Video,    sprite: [ sprOptionButtons, 1 ] },
	{ type: "category", name: "GAME",     category: OptionCategory.Game,     sprite: [ sprOptionButtons, 2 ] },
	{ type: "category", name: "CONTROLS", category: OptionCategory.Controls, sprite: [ sprOptionButtons, 3 ] },
	
	{
		type: "button", name: "RESOURCEPACKS", ingame: false,
		
		click: function() {
			self.category_set(OptionCategory.Resourcepacks)
			
			if !save_get_value("etc", "rp_warning", 0)
				rp_warning = true
		}
	},
	
	{ type: "category", name: "CHEATS",   category: OptionCategory.Cheats, ingame: false,
		awake: function(opt) {
			opt.visible = UberCont.opt_cheats
		}
	},
	
	{ type: "category", name: "DISPLAY",  category: OptionCategory.Video_Display, visible: false },
	
	{ type: "category", name: "PROFILE",  category: OptionCategory.Game_Profile,  visible: false },
	{ type: "category", name: "COLOR",    category: OptionCategory.Game_Color,    visible: false },
	{ type: "category", name: "DATA",     category: OptionCategory.Game_Data,     visible: false },
	
	{ type: "category", name: "REMAPPING", category: OptionCategory.Controls_Remapping, visible: false },
	{ type: "category", name: "REMAPPING", category: OptionCategory.Controls_Remapping_Keys, visible: false },
	{ type: "category", name: "CHAR PREFS", category: OptionCategory.Controls_Preferences, visible: false },
	{ type: "category", name: "EXPERIMENTAL OPTIONS", category: OptionCategory.Controls_Experimental, visible: false },
	
	{ type: "category", name: "CO-OP", category: OptionCategory.Coop_Menu, visible: false },
)

option_category_end()

#endregion
#region Audio

option_category_begin(OptionCategory.Audio)

option_elements_create(
	{ type: "slider",  name: "MASTER VOLUME",   key: "volume_master"       },
	{ type: "slider",  name: "MUSIC VOLUME",    key: "volume_music"        },
	{ type: "slider",  name: "AMBIENT VOLUME",  key: "volume_ambient"      },
	{ type: "slider",  name: "SFX VOLUME",      key: "volume_sfx"          },
	{ type: "switch",  name: "3D SOUND",        key: "volume_3dsound"      },
	{ type: "switch",  name: "STOP ON PAUSE",   key: "volume_pauseonpause" }
)

#endregion
#region Video

option_category_begin(OptionCategory.Video)

option_elements_create(
	{ type: "switch",  name: "FULLSCREEN",   key: "visual_resolution", mobile_only: true },
	
	{
		type: "list", name: "CROSSHAIR",     key: "options_crosshair",
		list: range(0, sprite_get_number(sprCrosshair) - 1),
		
		draw: function(opt) {
			if opt.value < sprite_get_number(sprCrosshair) - 1 {
				draw_sprite(sprCrosshair, opt.value, drawx + 90, drawy)
			}
			else draw_text_nt(drawx + 90, drawy, loc("NONE"))
		},
		
		value_get: function(opt) {
			return opt.value + 1
		}
	},
	
	{
		type: "list", name: "SIDE ART",      key: "options_sideart",
		list: range(0, sprite_get_number(sprSideArt) - 1),
		
		condition: function() {
			return !UberCont.opt_resolution
		},
		
		value_get: function(opt) {
			if opt.value == 0
				return loc("NONE")
			
			option_list_max --
			
			return opt.value
		}
	},
	
	{ type: "slider",  name: "SCREENSHAKE",      key: "visual_screenshake"  },
	{ type: "slider",  name: "FREEZE FRAMES",    key: "visual_freezeframes" },
	
	{ type: "switch",  name: "WALL FIX",         key: "visual_walls"        },
	{ type: "switch",  name: "PARTICLES",        key: "visual_particles",   states: [ SWITCH_STATE_ON, SWITCH_STATE_OFF ] },
	{ type: "switch",  name: "BLOOM",            key: "visual_bloom"        },
	{ type: "switch",  name: "HIDE HUD",         key: "visual_hud",         states: [ SWITCH_STATE_ON, SWITCH_STATE_OFF ] },
	
	{
		type: "list", name: "PIXEL MODE", key: "visual_scaling", list: range(1, 4),
		
		draw: function(opt) {
			if !instance_exists(debris) {
				debris = instance_create(view_xview + drawx + 90, view_yview + drawy, Debris)
				
				with debris {
					mask_index = mskNone
					image_index = 0
					
					speed = 0
					
					alarm[1] = 1
					alarm[0] = 2
				}
			}
			else {
				with debris
					alarm[0] = 2
			}
		}
	},
	
	{ type: "category", name: "DISPLAY SETTINGS", category: OptionCategory.Video_Display, desktop_only: true }
)

#endregion
#region Video_Display
option_category_begin(OptionCategory.Video_Display)

option_elements_create(
	{ type: "switch",  name: "FULL RESOLUTION",   key: "visual_resolution"   },
	{ type: "switch",  name: "FULLSCREEN",        key: "options_fullscreen",
		click: function (opt) {
			opt.value = !window_get_fullscreen()
			window_set_fullscreen(opt.value)
			
			scrSetViewSize(true)
			
		},
		
		value_get: function(opt) {
			return window_get_fullscreen()
		}
	},
	{ type: "switch",  name: "VSYNC",             key: "options_vsync",
		click: function(opt) {
			display_reset(0, opt.value)
			scrBignameSurfaceCleanup()
		}
	}
)

#endregion
#region Game

option_category_begin(OptionCategory.Game)

option_elements_create(
	{ type: "list",     name: "LANGUAGE",          key: "etc_language", list: languages },
	
	{ type: "switch",   name: "BOSS INTROS",       key: "visual_bossintro" },
	{ type: "switch",   name: "DYNAMIC CAMERA",    key: "visual_camera" },
	{ type: "switch",   name: "PLAY TUTORIAL",     key: "game_tutorial",  ingame: false },
	{ type: "switch",   name: "TIMER",             key: "visual_timer"     },
	{
		type: "switch", name: "CURSOR", desktop_only: true,
		states: [ "DEFAULT", "NATIVE" ], key: "options_cursor",
		
		condition: function(opt) {
			return native_cursor_dll
		}
	},
	
	{ type: "switch",   name: "MOUSELOCK",          key: "options_mouselock", desktop_only: true },
	
	{ type: "switch",   name: "PAUSE BUTTON",       key: "options_pausebutton", mobile_only: true },
	
	{ type: "switch",   name: "ACHIEVEMENT#POPUPS", key: "options_achievements" },
	
	{ type: "switch",   name: "AUTO PAUSE",         key: "options_autopause", desktop_only: true },
	
	{
		type: "button", name: "VIEW CREDITS", ingame: false,
		
		click: function(opt) {
			instance_create(0, 0, Credits)
			snd_play(sndMenuCredits)
			
			instance_destroy()
		}
	},
	
	{ type: "category", name: "PROFILE", category: OptionCategory.Game_Profile }
)

#endregion
#region Game_Color

option_category_begin(OptionCategory.Game_Color)

option_elements_create(
	{
		type: "input", name: "EDIT HEX", key: undefined, halign: fa_left,
		
		draw: function(opt) {
			var xx = gui_w / 2,
				yy = 64 + opt.anim,
				
				w = 72 + opt.anim,
				h = 6,
				
				val = "NONE"
			
			if global.player_color {
				draw_set_color(c_black)
				draw_rectangle(xx - w - 2, yy - h - 2, xx + w + 2, yy + h + 3, 0)
				
				draw_set_color(c_white)
				draw_rectangle(xx - w - 1, yy - h - 1, xx + w + 1, yy + h + 1, 0)
				
				draw_set_color(c_black)
				draw_rectangle(xx - w, yy - h, xx + w, yy + h, 0)
				
				draw_set_color(global.player_color)
				draw_rectangle(xx - w, yy - h + 1, xx + w, yy + h, 0)
				
				val = string(UberCont.opt_color)
			}
			
			draw_set_color(c_white)
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			draw_text_shadow(xx, yy + 1, val)
			
			draw_set_halign(opt.halign)
			draw_set_valign(opt.valign)
			
			return false
		},
		
		awake: function(opt) {
			opt.value = opt.value_get(opt)
			opt.previous = opt.value
			
			colorpicker_update_scales(global.player_color)
		},
		
		value_get: function(opt) {
			return UberCont.opt_color
		},
		
		validate: function(opt, str, confirm) {
			str = string(str)
			
			option_can_change = false
			
			if string_length(str) > 6 {
				opt.previous = string_delete(str, 7, string_length(str) - 6)
				opt.value = opt.previous
				
				return true
			}
			
			if (confirm && string_length(str) % 2 != 0)
				return true
			
			if confirm
				opt.value = base_convert(str, 16, 10)
			
			str = string_upper(str)
			
			for(var i = 1; i <= string_length(str); i ++) {
				var o = string_ord_at(str, i)
				
				if (o >= ord("A") && o <= ord("F")) or (o >= ord("0") && o <= ord("9"))
					continue
				
				return true
			}
			
			if confirm {
				colorpicker_update_scales(opt.value)
				colorpicker_update_options(opt.value)
			}
		}
	},
	
	{
		type: "slider", name: "RED", value: 0, key: "options_color",
		click: function(opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				opt.value * 255,
				color_get_green(col),
				color_get_blue(col)
			))
		}
	},
	
	{
		type: "slider", name: "GREEN", value: 0, key: "options_color",
		click: function(opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				color_get_red(col),
				opt.value * 255,
				color_get_blue(col)
			))
		}
	},
	
	{
		type: "slider", name: "BLUE", value: 0, key: "options_color",
		click: function(opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				color_get_red(col),
				color_get_green(col),
				opt.value * 255
			))
		}
	},
)

#endregion
#region Game_Profile

option_category_begin(OptionCategory.Game_Profile)

option_elements_create(
	{ type: "button", name: "ID", key: "general_uid",
		value_get: function(opt) {
			var value = scrGetUid(),
				copied = opt[$ "__copied"]
			
			if copied == undefined {
				if is_string(value) && string_length(value) >= 8
					return string_copy(value, 1, 5) + "..."
			}
			
			if copied - global.time > 0
				return "@g[COPIED]"
			
			return value
		},
		
		click: function(opt) {
			opt.value = scrGetUid()
			
			if global.desktop {
				clipboard_set_text(opt.value)
			}
			else if os_type == os_android {
				SetClipboard(opt.value)
			}
			else return;
			
			opt[$ "__copied"] = global.time + 15
		}
	},
	
	{ type: "input", name: "NICKNAME", key: "etc_name", ingame: false,
		validate: function(opt, str, confirm) {
			return scrValidateUsername(opt, str, confirm)
		},
		
		name_get: function(opt) {
			return text_input_element == opt ? "ENTER YOUR NICKNAME" : opt.name
		}
	},
	
	{ type: "button", name: "COLOR", key: "options_color", ingame: false,
		click: function () {
			option_can_change = false
			self.category_set(OptionCategory.Game_Color)
		},
		
		value_get: function(opt) {
			if !global.player_color
				return "DEFAULT"
			
			draw_set_color(global.player_color)
			
			return "[" + string(UberCont.opt_color) + "]"
		}
	},
	
	{
		type: "button", name: "AUTHORIZE WITH DISCORD", ingame: false,
		
		click: function(opt) {
			if auth_discord_logged
				return scrAuthorizationDeauth()
			
			with UberCont
				event_user(10)
		},
		
		name_get: function(opt) {
			return (auth_discord_logged ? $"DEAUTHORIZE @s({string_upper(auth_discord_username)})" : opt.name)
		}
	},
	
	{
		type: "category", name: "DATA", category: OptionCategory.Game_Data, ingame: false,
		
		awake: function(opt) {
			if instance_exists(NicknameInput)
				opt.visible = false
		}
	},
)

#endregion
#region Game_Data

option_category_begin(OptionCategory.Game_Data)

option_elements_create(
	{
		type: "button", name: "RESET OPTIONS",
		
		click: function() {
			disclaimer_pop = 1
			erasing_progress = 2
		}
	},
	
	{
		type: "button", name: "ERASE PROGRESS", ingame: false,
		
		click: function() {
			disclaimer_pop = 1
			erasing_progress = 1
		}
	},
)

#endregion
#region Controls

option_category_begin(OptionCategory.Controls)

option_elements_create(
	{ type: "switch", name: "GAMEPAD", key: "options_gamepad" },
	
	{ type: "list", name: "GAMEPAD STYLE", key: "options_gamepad_type", list: range(0, array_length(gamepad_types) - 1),
		condition: function() {
			return is_gamepad(global.index)
		},
		
		draw: function() {
			if option_selected {
				for(var i = 0; i < 4; i ++)
					draw_sprite(gamepad_icon_small, i, (gui_w / 2 - 32) + i * 16, startdrawy - 16)
			}
		},
		
		value_get: function(opt) {
			return loc(gamepad_types[opt.value])
		}
	},
	
	{ type: "switch", name: "AIM ASSIST",       key: "controls_assist",       mobile_only: true },
	{ type: "switch", name: "360 AIMBOT",       key: "controls_aimbot",       mobile_only: true },
	{ type: "switch", name: "VOLUME CONTROLS",  key: "options_volumecontrol", mobile_only: true },
	{ type: "switch", name: "SPLIT AIM & FIRE", key: "controls_splitfire",    mobile_only: true },
	{ type: "switch", name: "FIXED SIGHT",      key: "controls_fixsight",     mobile_only: true },
	
	{ type: "slider", name: "SIZE SCALE", key: "controls_scale", mobile_only: true },
	
	{ type: "button", name: "REMAP CONTROLS",
		name_get: function(opt) {
			var str = opt.name
			
			if is_gamepad()
				return str + " " + loc("(GAMEPAD)")
			
			if is_keyboard() && !global.desktop
				return str + " " + loc("(KEYBOARD)")
			
			return str
		},
		
		click: function() {
			if is_gamepad() or is_keyboard() {
				self.category_set(OptionCategory.Controls_Remapping_Keys)
				
				exit
			}
			
			editing_mode = true
	        remap_pos = 0
			
	        if !UberCont.opt_gamepad
	            scrCreateMobileControls()
			
			self.category_set(OptionCategory.Controls_Remapping, false)
		}
	},
	
	{ type: "category", name: "CHARACTER PREFERENCES", category: OptionCategory.Controls_Preferences }, // mobile_only: true }
	
	{ type: "category", name: "EXPERIMENTAL OPTIONS", category: OptionCategory.Controls_Experimental }
)

option_category_end()
#endregion Controls
#region Controls_Remapping
option_category_begin(OptionCategory.Controls_Remapping)

option_elements_create(
	{ type: "button", name: "DEFAULT PRESET",
		click: function() {
			var saveData = UberCont.saveData
			
			with MobileUI {
				ds_map_delete(saveData, "controls_" + key + "_x")
				ds_map_delete(saveData, "controls_" + key + "_y")
				
				instance_destroy()
			}
			
			scrCreateMobileControls()
			
			snd_play(sndRestart)
		},
		
		condition: function() {
			var any = false
			
			with MobileUI {
				if custom_position {
					any = true; break
				}
			}
			
			return any
		}
	},
	
	{ type: "switch", name: "SIMPLIFY", halign: fa_center, key: "visual_simplify", draw: draw_inline_switch }
)
#endregion Controls_Remapping
#region Controls_Remapping_Keys
option_category_begin(OptionCategory.Controls_Remapping_Keys)

condition_keyboard = function() { return (is_keyboard() && !is_gamepad()) }
condition_gamepad = function() { return is_gamepad() }

option_elements_create(
	{ type: "keybind", name: "FIRE", key: "fire" },
	{ type: "keybind", name: "ACTIVE", key: "spec" },
	{ type: "keybind", name: "SWAP", key: "swap" },
	{ type: "keybind", name: "PICK/USE", key: "pick" },
	
	{ type: "keybind", name: "COOP CHAT", key: "chat", condition: condition_keyboard },
	{ type: "keybind", name: "WALK UP", key: "north", condition: condition_keyboard },
	{ type: "keybind", name: "WALK DOWN", key: "south", condition: condition_keyboard },
	{ type: "keybind", name: "WALK LEFT", key: "west", condition: condition_keyboard },
	{ type: "keybind", name: "WALK RIGHT", key: "east", condition: condition_keyboard },
	
	{ type: "keybind", name: "OPEN CONSOLE", key: "console",
		awake: function(opt) {
			opt.visible = UberCont.opt_cheats or (ingame && !global.cheats)
		},
		
		condition: condition_keyboard
	},
	
	{ type: "button", name: "DEFAULT PRESET",
		click: function() {
			scrKeymapsSetup()
			scrOptionsSaveKeymaps()
			scrSave()
			
			snd_play(sndRestart)
		}
	}
)

#endregion Controls_Remapping_Keys
#region Controls_Preferences
option_category_begin(OptionCategory.Controls_Preferences)

cpref_condition = function(opt) { return UberCont.ctot_time[opt.char] > 0 }
cpref_name = function(opt) { return (!UberCont.ctot_time[opt.char]) ? "@d- LOCKED -" : "@(sprPlayerMapIcon:" + string(opt.char) + ")  " + loc(opt.name) }

option_elements_create(
	{ type: "switch", name: "AUTO TELEKINESIS",      key: "cprefs_eyes", char: 3,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "AUTO EXPLOSIONS",       key: "cprefs_melting", char: 4,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "AUTO SNARE",            key: "cprefs_plant", char: 5,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "POP-POP SWITCH",        key: "cprefs_yv", char: 6,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "DUAL WEILD SWITCH",     key: "cprefs_steroids", char: 7,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "USE WEAPON BEAMING",    key: "cprefs_horror", char: 11,
			condition: cpref_condition, name_get: cpref_name },
		
	{ type: "switch", name: "SWIPE BOMBING",         key: "cprefs_rogue", char: 12,
			condition: cpref_condition, name_get: cpref_name },
	
	{ type: "switch", name: "GAMBLE SWITCH",         key: "cprefs_skeleton", char: 14,
			condition: cpref_condition, name_get: cpref_name },
)


#endregion Controls_Preferences
#region Controls_Experimental

option_category_begin(OptionCategory.Controls_Experimental)

option_elements_create(
	{ type: "switch", name: "KEYBOARD MODE",    key: "options_keyboard" },
	
	{ type: "switch", name: "WEAPON-STICKS",    key: "controls_wepstick" },
	
	{ type: "switch", name: "STICK REGIONS",    key: "controls_stickregions" },
	
	{ type: "switch", name: "HIDE JOYSTICKS",   key: "controls_hiddensticks",
		value_get: function(opt) {
			if UberCont.opt_stickregions
				return true
			
			return opt.value
		},
		
		condition: function(opt) {
			return !UberCont.opt_stickregions
		}
	},
)

#endregion Controls_Experimental
#region Resourcepacks
option_category_begin(OptionCategory.Resourcepacks)

option_elements_create(
	{
		type: "button", name: "VIEW INSTALLED", ingame: false,
		
		click: function() {
			with instance_create(0, 0, ResourcepackManager) {
				browsing = false
				event_user(0)
			}
		}
	},
	
	{
		type: "button", name: "BROWSE AND DOWNLOAD", ingame: false,
		
		click: function() {
			with instance_create(0, 0, ResourcepackManager) {
				browsing = true
				event_user(0)
			}
		}
	},
	
	{
		type: "input", name: "DIRECT DOWNLOAD", value: "",
		
		validate: function(opt, str, confirm) {
			if confirm {
				var a = "https://github.com/"
				
				if string_starts(str, a)
					str = string_delete(str, 1, string_length(a))
				
				if string_char_at(str, string_length(str)) == "/"
					str = string_delete(str, string_length(str) - 1, 1)
				
				if string_count("/", str) != 1
					return true
				
				keyboard_string = ""
				opt.value = ""
				
				with instance_create(0, 0, ResourcepackManager) {
					var r = string_split(str, "/")
					
					if r[| 0] == ""
						ds_list_delete(r, 0)
					
					loaded = true
					browsing = true
					
					clicked_item = {
						full_name: str,
						owner: r[| 0],
						name: r[| 1]
					}
					
					self.direct_download(str)
					download_destroy = true
				}
			}
			
			return false
		}
	}
)

#endregion Resourcepacks
#region Cheats
option_category_begin(OptionCategory.Cheats)

option_elements_create(
	{ type: "switch", name: "CONSOLE", key: "cheats_console" },
	{ type: "switch", name: "GRILLER MODE", key: "cheats_griller" },
	{ type: "switch", name: "PRACTICE", key: "cheats_practice" }
)

#endregion Cheats

#region Coop_Menu
option_category_begin(OptionCategory.Coop_Menu)

option_elements_create(
	{ type: "category", name: "PROFILE", category: OptionCategory.Game_Profile },
	
	{
		type: "button", name: "HOST GAME",
		
		click: function() {
			
			if !instance_exists(CoopMenu) {
				with instance_create(0, 0, CoopMenu)
					menu = other.id
			}
			
			CoopMenu.host_game()
		}
	},
	
	{
		type: "button", name: "JOIN DIRECT",
		
		click: function() {
			
			if !instance_exists(CoopMenu) {
				with instance_create(0, 0, CoopMenu)
					menu = other.id
			}
			
			CoopMenu.join_remote(global.ip, global.port)
		}
	},
	
	{ type: "input", name: "REMOTE ADDRESS", key: "coop_lastip" },
	
	{
		type: "input", name: "REMOTE PORT", key: "coop_lastport",
		
		validate: function(opt, str, confirm) {
			if string_digits(str) != str or string_length(str) > 5
				return true
			
			if confirm && str == ""
				return true
		}
	},
	
	{ type: "button", name: "REFRESH LOCAL",
		condition: function (opt) {
			with CoopMenu {
				local_count = 0
				local_games = {}
				
				if local_wait
					return false
			}
			
			return true
		},
		
		click: function() {
			with CoopMenu {
				local_wait = 30
				local_games = {}
				
				snd_play(sndClick)
			}
		}
	}
)

local_game_template = {
	type: "button", name: "???'s GAME",
	
	ip: UberCont.opt_remote_ip,
	port: UberCont.opt_remote_port,
	
	click: function(opt) {
		CoopMenu.join_remote(opt.ip, opt.port)
	}
}

#endregion
option_category_end()
#endregion


element_functions = {}

element_functions[$ "category"] = function(opt) {
	self.category_set(opt.category)
	wait = 1
}

element_functions[$ "switch"] = function(opt) {
	opt.value ^= 1
}

element_functions[$ "list"] = function(opt) {
	var list = opt.list,
		index = array_indexof(list, opt.value)
	
	if index != -1 && array_length(list) > index + 1 {
		opt.value = list[index + 1]
	}
	else opt.value = list[0]
}

element_functions[$ "input"] = function(opt) {
	var v = method_execute(opt.value_get, opt) ?? opt.value
	
	opt.previous = v
	keyboard_string = v
	
	text_input_element = opt
	text_input_timer = 0
}

element_functions[$ "keybind"] = function(opt) {
	text_input_timer = 0
	
	await_input = true
	await_keybind = opt
	
	keyboard_lastkey = -1
	mouse_lastbutton = -1
}

// can be removed..?
foreach(options, function(val) {
    for (var i = 0; i < array_length(val); i++) {
        var v = val[i]
		
		if is_method(v[$ "awake"])
			method_execute(v.awake, v)
    }
})

dispose_on_empty = false