#macro timescale 1

#macro INT_MAX 0x7fffffff
#macro UINT_MAX 0xffffffff

#macro game_screen_width 320
#macro game_screen_height 240

#macro view_xview global.camera_x
#macro view_yview global.camera_y
#macro view_width global.camera_width
#macro view_height global.camera_height

#macro view_xview_center (view_xview + view_width div 2)
#macro view_yview_center (view_yview + view_height div 2)

#macro gui_w (display_get_gui_width())
#macro gui_h (display_get_gui_height())

#macro ldrx lengthdir_x
#macro ldry lengthdir_y

#macro game_speed_default 60
#macro game_speed_uncaped 9990
#macro game_speed (game_get_speed(gamespeed_fps))

#macro bbox_center_x ((bbox_left + bbox_right) / 2)
#macro bbox_center_y ((bbox_top + bbox_bottom) / 2)
#macro bbox_width (bbox_right - bbox_left)
#macro bbox_height (bbox_bottom - bbox_top)

#macro x_rel_view (x - view_xview)
#macro y_rel_view (y - view_yview)

#macro animation_end ((image_index + image_speed) > sprite_get_number(sprite_index))

#macro random_angle (random(360))

#macro DevelopmentMode false
#macro MultiplayerConfig false

#macro Development:DevelopmentMode true

#macro MultiplayerTesting:DevelopmentMode true
#macro MultiplayerTesting:MultiplayerConfig true

//

#macro mcr_floor_make_walls { \
		if !position_meeting(x - 16, y - 16, Floor) instance_create(x - 16, y - 16, Wall) \
	    if !position_meeting(x, y - 16, Floor) instance_create(x, y - 16, Wall)			  \
	    if !position_meeting(x + 16, y - 16, Floor) instance_create(x + 16, y - 16, Wall) \
	    if !position_meeting(x + 32, y - 16, Floor) instance_create(x + 32, y - 16, Wall) \
	    if !position_meeting(x + 32, y, Floor) instance_create(x + 32, y, Wall)			  \
	    if !position_meeting(x + 32, y + 16, Floor) instance_create(x + 32, y + 16, Wall) \
	    if !position_meeting(x - 16, y, Floor) instance_create(x - 16, y, Wall)			  \
	    if !position_meeting(x - 16, y + 16, Floor) instance_create(x - 16, y + 16, Wall) \
	    if !position_meeting(x - 16, y + 32, Floor) instance_create(x - 16, y + 32, Wall) \
	    if !position_meeting(x, y + 32, Floor) instance_create(x, y + 32, Wall)			  \
	    if !position_meeting(x + 16, y + 32, Floor) instance_create(x + 16, y + 32, Wall) \
	    if !position_meeting(x + 32, y + 32, Floor) instance_create(x + 32, y + 32, Wall) \
	}

#macro mcr_floor_create_tops { \
		instance_create(x - 32, y, Top)		 \
		instance_create(x + 32, y, Top)		 \
		instance_create(x, y + 32, Top)		 \
		instance_create(x, y - 32, Top)		 \
		instance_create(x - 32, y + 32, Top) \
		instance_create(x + 32, y + 32, Top) \
		instance_create(x - 32, y - 32, Top) \
		instance_create(x + 32, y - 32, Top) \
	}

#macro mcr_wall_update_lrwh { \
		if (place_free(x - 16, y)) l = 0 else l = 4           \
	    if (place_free(x + 16, y)) w = 24 - l else w = 20 - l \
	    if (place_free(x, y - 16)) r = 0 else r = 4           \
	    if (place_free(x, y + 16)) h = 24 - r else h = 20 - r \
	}

//

view_width = 320
view_height = 240

view_xview = 0
view_yview = 0

globalvar view_width_max, window_min_width, window_min_height;

view_width_max = game_screen_height * scr_display_get_aspect_ratio()
window_min_width = game_screen_width * 2
window_min_height = game_screen_height * 2

function scrSetViewSize(_resize_window = true) {
	with UberCont {
	    var _width = game_screen_width,
			_height = game_screen_height,
			_render_scale = opt_scaling
		
	    if opt_resolution {
			_width = view_width_max
			
			if _width < game_screen_width {
				_width = game_screen_width
			}
		}
		
		if _height % 2 != 0 {
			_height = floor(_height + 1)
		}
		
		_width = floor(_width)
		_height = floor(_height)
		
		var _render_width = _width * _render_scale,
			_render_height = _height * _render_scale
		
		room_set_view(romInit, 0, true, 0, 0, _width, _height, 0, 0, _render_width, _render_height, 0, 0, 0, 0, noone)
		room_set_view(romGame, 0, true, 0, 0, _width, _height, 0, 0, _render_width, _render_height, 0, 0, 0, 0, noone)
		room_set_view_enabled(romGame, 1)
		
	    surface_resize(application_surface, _render_width, _render_height)
	    camera_set_view_border(view_camera, _render_width, _render_height)
		
	    camera_set_view_size(view_camera, _width, _height)
		display_set_gui_size(_width, _height)
		
	    view_width = _width
	    view_height = _height
		
	    if is_desktop && _resize_window {
			window_min_width = game_screen_width * 3
			window_min_height = game_screen_height * 3
			
			if (scr_display_get_width() <= window_min_width
				|| scr_display_get_height() <= window_min_height
			) {
				window_min_width = game_screen_width * 2
				window_min_height = game_screen_height * 2
			}
			
	        window_set_min_width(window_min_width)
	        window_set_min_height(window_min_height)
			window_set_size(window_min_width, window_min_height)
			scrWindowUpdateWindowedPosition()
	    }
	}
}

function scrWindowUpdateWindowedPosition() {
	if !is_desktop || scr_window_get_fullscreen() exit
	
	window_set_position(
		(scr_display_get_width() div 2) - (window_min_width div 2),
		(scr_display_get_height() div 2) - (window_min_height div 2))
	
	if global.__window_borderless_fs_enabled {
		window_enable_borderless_fullscreen(false)
	}
}

function scrDrawAlignCenter() { draw_set_halign(fa_center); draw_set_valign(fa_middle) }
function scrDrawAlignDefault() { draw_set_halign(fa_left); draw_set_valign(fa_top) }

global.index = 0

globalvar KeyCont;

KeyCont = {
	touch: [0, 0, 0, 0],
	gamepad: [0, 0, 0, 0],
	keyboard: [0, 0, 0, 0],
	
    aimassist: [0, 0, 0, 0],
    activeforever: [0, 0, 0, 0],
	precisemovement: [ 0, 0, 0, 0 ],
    moving: [0, 0, 0, 0],
	
    dir_move: [0, 0, 0, 0],
    dir_fire: [0, 0, 0, 0],
	dis_fire: [0, 0, 0, 0],
	
	key_west: [0, 0, 0, 0],
	key_east: [0, 0, 0, 0],
	key_nort: [0, 0, 0, 0],
	key_sout: [0, 0, 0, 0],
	
    crosshair: [0, 0, 0, 0],

    players: 1
}

var keys = ["fire", "spec", "pick", "swap", "paus", "horn"]

for (var i = 0; i < array_length(keys); i++) {
    KeyCont[$ "press_" + keys[i]] = [0, 0, 0, 0]
    KeyCont[$ "release_" + keys[i]] = [0, 0, 0, 0]

    KeyCont[$ "hold_" + keys[i]] = [0, 0, 0, 0]
}

global.input_keys_list = [
	"gamepad",
	"keyboard",
	"aimassist",
	
	"activeforever",
	
	"press_fire",
	"press_spec",
	"press_pick",
	"press_swap",
	"press_paus",
	"press_horn",
	
	"release_fire",
	"release_spec",
	"release_pick",
	"release_swap",
	"release_paus",
	"release_horn",
	
	"hold_fire",
	"hold_spec",
	"hold_pick",
	"hold_swap",
	"hold_paus",
	"hold_horn"
]

global.input_keys_list_length = array_length(global.input_keys_list)
global.inputs_current = ""

function scrInputBitmask() {
	var val = 0
	
	global.inputs_current = ""
	
	for(var i = 0; i < global.input_keys_list_length; i ++) {
		var key = global.input_keys_list[i]
		
		if KeyCont[$ key][global.index] {
			global.inputs_current += key + ": " + string(KeyCont[$ key][global.index]) + "\n"
			
			val |= (1 << i)
		}
	}
	
	return val
}

function scrGamepadKeyName(key) {
    switch key {
        case gp_shoulderl:
            return "LEFT SHOULDER"
        case gp_shoulderr:
            return "RIGHT SHOULDER"
        case gp_shoulderlb:
            return "LEFT SHOULDER B."
        case gp_shoulderrb:
            return "RIGHT SHOULDER B."

        case gp_face1:
            return "FACE 1"
        case gp_face2:
            return "FACE 2"
        case gp_face3:
            return "FACE 3"
        case gp_face4:
            return "FACE 4"

        case gp_padd:
            return "DPAD DOWN"
        case gp_padu:
            return "DPAD UP"
        case gp_padr:
            return "DPAD RIGHT"
        case gp_padl:
            return "DPAD LEFT"

        case gp_start:
            return "START"
        case gp_select:
            return "SELECT"

        default:
            return "unknown"
    }
}

function scrKeyName(key) {
	switch key {
		case mb_left:
			return "LMB"
		case mb_right:
			return "RMB"
		case mb_middle:
			return "MIDDLE"
		
		case vk_shift:
			return "SHIFT"
		case vk_control:
			return "CTRL"
		case vk_enter:
			return "ENTER"
		case vk_space:
			return "SPACE"
		case vk_alt:
			return "ALT"
		case vk_delete:
			return "DELETE"
		case vk_end:
			return "END"
		case vk_tab:
			return "TAB"
		case vk_escape:
			return "ESC"
		case vk_tilde:
			return "~"
		case ord("/"):
			return "/"
		
		case vk_up:
			return "UP"
		case vk_down:
			return "DOWN"
		case vk_left:
			return "LEFT"
		case vk_right:
			return "RIGHT"
	}
	
	if key >= ord("A") && key <= ord("Z")
	or key >= ord("0") && key <= ord("9")
	or key == ord("/")
		return chr(key)
	
	if key >= vk_f1 && key <= vk_f12 {
		var f = key - vk_f1
		return "F" + string(f + 1)
	}
	
	return "??"
}

function scrGamepadAnykey() {
    if gamepad_button_check_pressed(0, gp_shoulderl) {
        return gp_shoulderl
    }
	else if gamepad_button_check_pressed(0, gp_shoulderr) {
        return gp_shoulderr
    }
	else if gamepad_button_check_pressed(0, gp_shoulderlb) {
        return gp_shoulderlb
    }
	else if gamepad_button_check_pressed(0, gp_shoulderrb) {
        return gp_shoulderrb
    }
	else if gamepad_button_check_pressed(0, gp_face1) {
        return gp_face1
    }
	else if gamepad_button_check_pressed(0, gp_face2) {
        return gp_face2
    }
	else if gamepad_button_check_pressed(0, gp_face3) {
        return gp_face3
    }
	else if gamepad_button_check_pressed(0, gp_face4) {
        return gp_face4
    }
	else if gamepad_button_check_pressed(0, gp_padd) {
        return gp_padd
    }
	else if gamepad_button_check_pressed(0, gp_padu) {
        return gp_padu
    }
	else if gamepad_button_check_pressed(0, gp_padr) {
        return gp_padr
    }
	else if gamepad_button_check_pressed(0, gp_padl) {
        return gp_padl
    }
	else if gamepad_button_check_pressed(0, gp_start) {
        return gp_start
    }
	else if gamepad_button_check_pressed(0, gp_select) {
        return gp_select
    }
	else if scr_keyboard_check_pressed(vk_space) {
        return gp_face1
    }
	else if gamepad_button_check_pressed(0, gp_stickl) {
        return gp_stickl
    }
	else if scr_keyboard_check_pressed(gp_stickr) {
        return gp_stickr
    }

    return -1
}

function scrHandleInputsGeneral(_index) {
	var _k = KeyCont
	
	_k.press_horn[_index] = 0
	_k.gamepad[_index] = opt_gamepad
	_k.keyboard[_index] = opt_keyboard
	_k.aimassist[_index] = opt_assist
	_k.crosshair[_index] = opt_crosshair
	
	_k.touch[_index] = !(opt_gamepad || opt_keyboard)
	
	_k.precisemovement[_index] = (_k.touch[_index] || _k.gamepad[_index])
	
	// generic inputs
	if opt_gamepad || opt_keyboard {
	    _k.hold_fire[_index] = key_check("fire", keystate_hold)
	    _k.press_fire[_index] = key_check("fire", keystate_press)
	    _k.release_fire[_index] = key_check("fire", keystate_release)
		
	    _k.hold_spec[_index] = key_check("spec", keystate_hold)
	    _k.press_spec[_index] = key_check("spec", keystate_press)
	    _k.release_spec[_index] = key_check("spec", keystate_release)
		
	    _k.hold_swap[_index] = key_check("swap", keystate_hold)
	    _k.press_swap[_index] = key_check("swap", keystate_press)
	    _k.release_swap[_index] = key_check("swap", keystate_release)
		
	    _k.hold_pick[_index] = key_check("pick", keystate_hold)
	    _k.press_pick[_index] = key_check("pick", keystate_press)
	    _k.release_pick[_index] = key_check("pick", keystate_release)
		
	    _k.hold_horn[_index] = key_check("horn", keystate_hold)
	    _k.press_horn[_index] = key_check("horn", keystate_press)
	    _k.release_horn[_index] = key_check("horn", keystate_release)
	}
	
	// gamepad
	if opt_gamepad {
	    scrSetGamepadInputs(_index)
	}
	// keyboard
	else if opt_keyboard {
	    scrSetKeyboardInputs(_index)
		
	    if localcoop {
	        scrSetGamepadInputs(1)
	    }
		else if gamepad_button_check(0, gp_start) {
	        opt_gamepad = true
	    }
		
		// keyboard ui control
		if instance_exists(ParButton) {
			var _count = min(10, instance_number(ParButton))
	        for (var i = 0; i < _count; i++) {
	            if scr_keyboard_check_pressed(ord(string(i + 1))) {
	                with instance_find(ParButton, i) {
	                    selected = 1
	                    event_perform(ev_mouse, ev_left_press)
	                }
	                break
	            }
	        }
	    }
	}
	// mobile touchscreen
	else {
		// reset swap inputs in case of using wepsticks
		if opt_wepstick {
			KeyCont.hold_swap[_index] = false
			KeyCont.press_swap[_index] = false
			KeyCont.release_swap[_index] = false
		}
		
		// reset previous input states
		if !instance_exists(MobileUI) {
			KeyCont.press_swap[_index] = false
		}
		
		if volqueue != -1 && ds_queue_size(volqueue) {
			var _volume_input = ds_queue_dequeue(volqueue)
			scrHandleVolumeControl(_volume_input[0], _volume_input[1])
		}
		
		// call control elements logic
		with MobileUI {
			if UberCont.opt_stickregions && !instance_exists(MenuOptions) {
				if (object_index == JoystickMove || object_index == JoystickAttack) {
					for(var i = 0; i <= 4; i ++) scrStickRegions(i)
				}
			}
			
			if (object_index != ButtonActive) event_user(0)
		}
		
		// always ran last
		with (ButtonActive) event_user(0)
		
		// keep track of touch durations
		var _count = array_length(touch_duration)
	    for (var i = 0; i < _count; ++i) {
	        if device_mouse_check_button(i, mb_left) {
	            touch_duration[i] ++
	        }
			else {
				touch_duration[i] = 0
			}
		}
	}
}

function scrSetGamepadInputs(_index = 0) {
	var _kh, _kv;
	
    _kh = gamepad_axis_value(0, gp_axislh)
	_kv = gamepad_axis_value(0, gp_axislv)
	
    if !(abs(_kh) == 0 && abs(_kv) == 0) {
        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
        KeyCont.moving[_index] = true
    }
	else KeyCont.moving[_index] = false
	
    _kh = gamepad_axis_value(0, gp_axisrh)
	_kv = gamepad_axis_value(0, gp_axisrv)

    if !(abs(_kh) == 0 && abs(_kv) == 0) {
        KeyCont.dir_fire[_index] = point_direction(0, 0, _kh, _kv)
		KeyCont.dis_fire[_index] = point_distance(0, 0, _kh, _kv)
    }
}

function scrSetKeyboardInputs(_index = 0) {
	var _east = key_check("east"),
		_west = key_check("west"),
		_sout = key_check("south"),
		_nort = key_check("north")
	
	KeyCont.key_east[_index] = _east
	KeyCont.key_west[_index] = _west
	KeyCont.key_sout[_index] = _sout
	KeyCont.key_nort[_index] = _nort
	
    var _kh = (_east - _west), _kv = (_sout - _nort);
	
    if !(_kh == 0 && _kv == 0) {
        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
        KeyCont.moving[_index] = true
    }
	else KeyCont.moving[_index] = false
	
	if !is_mouse_over_debug_overlay() {
		with Player {
			if index != _index continue
			KeyCont.dis_fire[_index] = point_distance(x, y, mouse_x, mouse_y)
			KeyCont.dir_fire[_index] = point_direction(x, y, mouse_x, mouse_y)
		}
	}
}

function month_name_short(month) {
    switch month {
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAY"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10:
            return "OCT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
    }

    return "??"
}

#macro mouse_hover ()

function mouse_ui_clicked() {
	if (is_mobile) {
		for(var i = 0; i < 4; i ++) {
			if (device_mouse_check_button_released(i, mb_left)) return true
		}
		
		return false
	}
	
	return mouse_check_button_pressed(mb_left)
}

/// @function mouse_ui_hovered
/// @param instance
/// @param is_gui=false
function mouse_ui_hovered(_instance, _gui = false) {
	if (is_mouse_over_debug_overlay()) {
		return false
	}
	
	if (is_mobile) {
		for(var i = 0; i < 4; i ++) {
			if (!(device_mouse_check_button(i, mb_left)
				|| device_mouse_check_button_pressed(i, mb_left)
				|| device_mouse_check_button_released(i, mb_left))
			) {
				continue
			}
			
			var _mx = _gui ? device_mouse_x_to_gui(i) : device_mouse_x(i),
				_my = _gui ? device_mouse_y_to_gui(i) : device_mouse_y(i)
			
			if (collision_point(_mx, _my, object_index, false, false) == _instance) {
				return true
			}
		}
		
		return false
	}
	
	var _mx = _gui ? device_mouse_x_to_gui(0) : mouse_x,
		_my = _gui ? device_mouse_y_to_gui(0) : mouse_y
	
	return (collision_point(_mx, _my, object_index, false, false) == _instance)
}

function input_ui_horizontal_pressed() {
	var v = input_gamepad_check_pressed(0, gp_padr) - input_gamepad_check_pressed(0, gp_padl)
	
	if (v == 0) {
		return scr_keyboard_check_pressed(vk_right) - scr_keyboard_check_pressed(vk_left)
	}
	
	return v
}

function keyboard_anykey() {
	return !scr_keyboard_check_held(vk_alt) && scr_keyboard_check_pressed(vk_anykey)
}

/// @function scr_camera_set_position
/// @param x
/// @param y
/// @param halign = fa_left
/// @param valign = fa_top
function scr_camera_set_position(_x, _y, _halign = fa_left, _valign = fa_top) {
	if (_halign == fa_center) view_xview -= view_width div 2
	else if (_halign == fa_right) view_xview -= view_width
	
	if (_valign == fa_middle) view_yview -= view_height div 2
	else if (_valign == fa_bottom) view_yview -= view_height
	
	view_xview = _x
	view_yview = _y
	
	camera_set_view_pos(view_camera[0], _x, _y)
}

function approach(a, b, v) {
	return (b < a ? max(b, a - v) : min(a + v, b))
}

function image_rescale(_scale_multiplier) {
	image_xscale *= _scale_multiplier
	image_yscale *= _scale_multiplier
}

function sprite_get_bbox_width(_sprite) {
	return sprite_get_bbox_right(_sprite) - sprite_get_bbox_left(_sprite)
}

function sprite_get_bbox_height(_sprite) {
	return sprite_get_bbox_bottom(_sprite) - sprite_get_bbox_top(_sprite)
}

/// @function draw_align
/// @param halign=fa_left
/// @param valign=fa_top
function draw_align(_halign = fa_left, _valign = fa_top) {
	gml_pragma("forceinline")
	draw_set_halign(_halign)
	draw_set_valign(_valign)
}

/// @function scr_game_timesources_set_paused
/// @param is_paused
function scr_game_timesources_set_paused(_paused) {
	var _list = array_filter(time_source_get_children(time_source_game), function(_id) {
		
		if time_source_get_state(_id) == time_source_state_stopped {
			time_source_destroy(_id)
		}
		
		return time_source_exists(_id)
	})
	
	if _paused {
		array_foreach(_list, function(_id) {
			if time_source_get_state(_id) != time_source_state_active
				time_source_pause(_id)
		})
	}
	else {
		array_foreach(_list, function(_id) {
			if time_source_get_state(_id) == time_source_state_paused
				time_source_resume(_id)
		})
	}
}

/// @function call_after
/// @param n_frames
/// @param callback
function call_after(_delay, _callback) {
	var _info = {
		callback: _callback,
		timesource: -1
	}
			
	var _ts = time_source_create(time_source_game, _delay,
		time_source_units_frames, method(_info, function() {
			time_source_destroy(timesource)
			method_call(callback)
		}))
	
	_info.timesource = _ts
	
	time_source_start(_ts)
	
	return _ts
}

function t_lerp(a, b, amount) {
	return lerp(b, a, power(1 - amount, timescale))
}


#macro mcr_target_direction point_direction(x, y, target.x, target.y)

#macro wep_none 0
#macro wep_revolver 1
#macro wep_triple_machinegun 2
#macro wep_wrench 3
#macro wep_machinegun 4
#macro wep_shotgun 5
#macro wep_crossbow 6
#macro wep_grenade_launcher 7
#macro wep_double_shotgun 8
#macro wep_minigun 9
#macro wep_auto_shotgun 10
#macro wep_auto_crossbow 11
#macro wep_super_crossbow 12
#macro wep_shovel 13
#macro wep_bazooka 14
#macro wep_sticky_launcher 15
#macro wep_smg 16
#macro wep_assault_rifle 17
#macro wep_disc_gun 18
#macro wep_laser_pistol 19
#macro wep_laser_rifle 20
#macro wep_slugger 21
#macro wep_gatling_slugger 22
#macro wep_assault_slugger 23
#macro wep_energy_sword 24
#macro wep_super_slugger 25
#macro wep_hyper_rifle 26
#macro wep_screwdriver 27
#macro wep_laser_minigun 28
#macro wep_blood_launcher 29
#macro wep_splinter_gun 30
#macro wep_toxic_bow 31
#macro wep_sentry_gun 32
#macro wep_wave_gun 33
#macro wep_plasma_gun 34
#macro wep_plasma_cannon 35
#macro wep_energy_hammer 36
#macro wep_jackhammer 37
#macro wep_flak_cannon 38
#macro wep_golden_revolver 39
#macro wep_golden_wrench 40
#macro wep_golden_machinegun 41
#macro wep_golden_shotgun 42
#macro wep_golden_crossbow 43
#macro wep_golden_grenade_launcher 44
#macro wep_golden_laser_pistol 45
#macro wep_chicken_sword 46
#macro wep_nuke_launcher 47
#macro wep_ion_cannon 48
#macro wep_quadruple_machinegun 49
#macro wep_flamethrower 50
#macro wep_dragon 51
#macro wep_flare_gun 52
#macro wep_energy_screwdriver 53
#macro wep_hyper_launcher 54
#macro wep_laser_cannon 55
#macro wep_rusty_revolver 56
#macro wep_lightning_pistol 57
#macro wep_lightning_rifle 58
#macro wep_lightning_shotgun 59
#macro wep_super_flak_cannon 60
#macro wep_sawed_off_shotgun 61
#macro wep_splinter_pistol 62
#macro wep_super_splinter_gun 63
#macro wep_lightning_smg 64
#macro wep_smart_gun 65
#macro wep_heavy_crossbow 66
#macro wep_blood_hammer 67
#macro wep_lightning_cannon 68
#macro wep_pop_gun 69
#macro wep_plasma_rifle 70
#macro wep_pop_rifle 71
#macro wep_toxic_launcher 72
#macro wep_flame_cannon 73
#macro wep_lightning_hammer 74
#macro wep_flame_shotgun 75
#macro wep_double_flame_shotgun 76
#macro wep_auto_flame_shotgun 77
#macro wep_cluster_launcher 78
#macro wep_grenade_shotgun 79
#macro wep_grenade_rifle 80
#macro wep_rogue_rifle 81
#macro wep_party_gun 82
#macro wep_double_minigun 83
#macro wep_gatling_bazooka 84
#macro wep_auto_grenade_shotgun 85
#macro wep_ultra_revolver 86
#macro wep_ultra_laser_pistol 87
#macro wep_sledgehammer 88
#macro wep_heavy_revolver 89
#macro wep_heavy_machinegun 90
#macro wep_heavy_slugger 91
#macro wep_ultra_shovel 92
#macro wep_ultra_shotgun 93
#macro wep_ultra_crossbow 94
#macro wep_ultra_grenade_launcher 95
#macro wep_plasma_minigun 96
#macro wep_devastator 97
#macro wep_golden_plasma_gun 98
#macro wep_golden_slugger 99
#macro wep_golden_splinter_gun 100
#macro wep_golden_screwdriver 101
#macro wep_golden_bazooka 102
#macro wep_golden_assault_rifle 103
#macro wep_super_disc_gun 104
#macro wep_heavy_auto_crossbow 105
#macro wep_heavy_assault_rifle 106
#macro wep_blood_cannon 107
#macro wep_dog_spin_attack 108
#macro wep_dog_missile 109
#macro wep_incinerator 110
#macro wep_super_plasma_cannon 111
#macro wep_seeker_pistol 112
#macro wep_seeker_shotgun 113
#macro wep_eraser 114
#macro wep_guitar 115
#macro wep_bouncer_smg 116
#macro wep_bouncer_shotgun 117
#macro wep_hyper_slugger 118
#macro wep_super_bazooka 119
#macro wep_frog_pistol 120
#macro wep_black_sword 121
#macro wep_golden_nuke_launcher 122
#macro wep_golden_disc_gun 123
#macro wep_heavy_grenade_launcher 124
#macro wep_gun_gun 125
#macro wep_eggplant 126
#macro wep_golden_frog_pistol 127
#macro wep_electric_guitar 128

#macro mut_none 0
#macro mut_rhino_skin 1
#macro mut_extra_feet 2
#macro mut_plutonium_hunger 3
#macro mut_rabbit_paw 4
#macro mut_throne_butt 5
#macro mut_lucky_shot 6
#macro mut_bloodlust 7
#macro mut_gamma_guts 8
#macro mut_second_stomach 9
#macro mut_back_muscle 10
#macro mut_scarier_face 11
#macro mut_euphoria 12
#macro mut_long_arms 13
#macro mut_boiling_veins 14
#macro mut_shotgun_shoulders 15
#macro mut_recycle_gland 16
#macro mut_laser_brain 17
#macro mut_last_wish 18
#macro mut_eagle_eyes 19
#macro mut_impact_wrists 20
#macro mut_bolt_marrow 21
#macro mut_stress 22
#macro mut_trigger_fingers 23
#macro mut_sharp_teeth 24
#macro mut_patience 25
#macro mut_hammerhead 26
#macro mut_strong_spirit 27
#macro mut_open_mind 28
#macro mut_heavy_heart 29


#macro crwn_random 0
#macro crwn_none 1
#macro crwn_death 2
#macro crwn_life 3
#macro crwn_haste 4
#macro crwn_guns 5
#macro crwn_hatred 6
#macro crwn_blood 7
#macro crwn_destiny 8
#macro crwn_love 9
#macro crwn_luck 10
#macro crwn_curses 11
#macro crwn_risk 12
#macro crwn_protection 13


#macro area_campfire 0
#macro area_desert 1
#macro area_sewers 2
#macro area_scrapyards 3
#macro area_caves 4
#macro area_city 5
#macro area_labs 6
#macro area_palace 7
#macro area_vault 100
#macro area_oasis 101
#macro area_pizza_sewers 102
#macro area_mansion 103
#macro area_cursed_caves 104
#macro area_jungle 105
#macro area_hq 106
#macro area_crib 107
