#macro border_width 48

#macro c_gold      9490650
#macro c_ultra     1492541
#macro c_tooltip   4008241
#macro c_uigray    0x999999
#macro c_uidark    0x333333

#macro INT_MAX 2147483647

#macro view_width global.g_view_width
#macro view_height global.g_view_height
#macro view_xview global.g_view_xview
#macro view_yview global.g_view_yview

#macro gui_w (display_get_gui_width())
#macro gui_h (display_get_gui_height())

#macro DrawAlignCenter draw_set_halign(fa_center); draw_set_valign(fa_center)
#macro DrawAlignDefault draw_set_halign(fa_left); draw_set_valign(fa_top)

#macro ldrx lengthdir_x
#macro ldry lengthdir_y

#macro bbox_center_x ((bbox_left + bbox_right) / 2)
#macro bbox_center_y ((bbox_top + bbox_bottom) / 2)
#macro bbox_width (bbox_right - bbox_left)
#macro bbox_height (bbox_bottom - bbox_top)

#macro x_rel_view (x - view_xview)
#macro y_rel_view (y - view_yview)

// Multiplayer PlayerInstance index
global.index = 0

globalvar lockstep_stop, localizations_list;
localizations_list = { en: {} }
lockstep_stop = 0

global.localization_current = {}

view_width = 320
view_height = 240

view_xview = 0
view_yview = 0

global.desktop = 0

global.view_width_max = view_width

function scrSetViewSize(windowresize = 1) {
    var aspect_ratio = display_get_width() / display_get_height(),
		
		s = UberCont.opt_scaling,
		
		w = 320,
		h = 240
	
    ideal_width = w
    ideal_height = h
	
    global.view_width_max = round(ideal_height * aspect_ratio)
	
    if UberCont.opt_resolution
        ideal_width = global.view_width_max
	
    if ideal_width < w
		ideal_width = w
	
    if ideal_width & 1
		ideal_width ++
	
    view_width = ideal_width
    view_height = ideal_height
	
	room_set_view(romInit, 0, true, 0, 0, ideal_width, ideal_height, 0, 0, ideal_width * s, ideal_height * s, 0, 0, 0, 0, noone);
	room_set_view(romGame, 0, true, 0, 0, ideal_width, ideal_height, 0, 0, ideal_width * s, ideal_height * s, 0, 0, 0, 0, noone);
	room_set_view_enabled(romGame, 1)
	
    camera_set_view_size(view_camera, ideal_width, ideal_height)
	display_set_gui_size(ideal_width, ideal_height)
	
    surface_resize(application_surface, ideal_width * s, ideal_height * s)
    camera_set_view_border(view_camera, ideal_width * s, ideal_height * s)
	
    room_set_width(romGame, ideal_width)
    room_set_height(romGame, ideal_height)
	
    if global.desktop && windowresize {
        window_set_size(view_width, view_height)
        window_set_min_width(view_width)
        window_set_min_height(view_height)
    }
}

global.index = 0

#macro KeyCont global._KeyCont

KeyCont = {
	gamepad: [0, 0, 0, 0],
	keyboard: [0, 0, 0, 0],
    aimassist: [0, 0, 0, 0],
	
    activeforever: [0, 0, 0, 0],
    moving: [0, 0, 0, 0],
	
	
    dir_move: [0, 0, 0, 0],
    dir_fire: [0, 0, 0, 0],
	dis_fire: [0, 0, 0, 0],
	
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
	"moving",
	
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
		case vk_tidle:
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
	else if keyboard_check_pressed(vk_space) {
        return gp_face1
    }
	else if gamepad_button_check_pressed(0, gp_stickl) {
        return gp_stickl
    }
	else if keyboard_check_pressed(gp_stickr) {
        return gp_stickr
    }

    return -1
}

function scrHandleInputsGeneral(index) {
	var kc = KeyCont
	
	kc.press_horn[index] = 0
	
	kc.gamepad[index] = opt_gamepad
	kc.keyboard[index] = opt_keyboard
	kc.aimassist[index] = opt_assist
	kc.crosshair[index] = opt_crosshair
	
	// generic inputs
	if opt_gamepad or opt_keyboard {
	    kc.hold_fire[index] = key_check("fire", keystate_hold)
	    kc.press_fire[index] = key_check("fire", keystate_press)
	    kc.release_fire[index] = key_check("fire", keystate_release)
		
	    kc.hold_spec[index] = key_check("spec", keystate_hold)
	    kc.press_spec[index] = key_check("spec", keystate_press)
	    kc.release_spec[index] = key_check("spec", keystate_release)
		
	    kc.hold_swap[index] = key_check("swap", keystate_hold)
	    kc.press_swap[index] = key_check("swap", keystate_press)
	    kc.release_swap[index] = key_check("swap", keystate_release)
		
	    kc.hold_pick[index] = key_check("pick", keystate_hold)
	    kc.press_pick[index] = key_check("pick", keystate_press)
	    kc.release_pick[index] = key_check("pick", keystate_release)
		
	    kc.hold_horn[index] = key_check("horn", keystate_hold)
	    kc.press_horn[index] = key_check("horn", keystate_press)
	    kc.release_horn[index] = key_check("horn", keystate_release)
	}
	
	// gamepad
	if opt_gamepad {
	    scrSetGamepadInputs(index)
	}
	// keyboard
	else if opt_keyboard {
	    scrSetKeyboardInputs(index)
		
	    if localcoop {
	        scrSetGamepadInputs(1)
	    }
		else if gamepad_button_check(0, gp_start) {
	        opt_gamepad = 1
	    }
		
		// keyboard ui control
		if instance_exists(ParButton) {
	        for (var i = 0; i < min(10, instance_number(ParButton)); i++) {
	            if keyboard_check_pressed(ord(string(i + 1))) {
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
		// call control elements logic
		with MobileUI
			event_user(0)
		
		// for global touches
	    for (var i = 0; i < array_length(touch_duration); i++) {
	        if device_mouse_check_button(i, mb_left) {
	            touch_duration[i] ++
	        }
			else touch_duration[i] = 0
	    }
	}
}

function scrSetGamepadInputs(index = 0) {
    var kh = gamepad_axis_value(0, gp_axislh)
    var kv = gamepad_axis_value(0, gp_axislv)

    KeyCont.moving[index] = 0

    if abs(kh) > 0.1 or abs(kv) > 0.1 {
        KeyCont.dir_move[index] = point_direction(0, 0, kh, kv)
        KeyCont.moving[index] = point_distance(0, 0, kh, kv)
    }
	
    var kh = gamepad_axis_value(0, gp_axisrh)
    var kv = gamepad_axis_value(0, gp_axisrv)

    if abs(kh) > 0.1 or abs(kv) > 0.1 {
        KeyCont.dir_fire[index] = point_direction(0, 0, kh, kv)
		KeyCont.dis_fire[index] = point_distance(0, 0, kh, kv)
    }
}

function scrSetKeyboardInputs(index = 0) {
    var kh = key_check("east") - key_check("west")
    var kv = key_check("south") - key_check("north")

    KeyCont.moving[index] = 0

    if kh != 0 or kv != 0 {
        KeyCont.dir_move[index] = point_direction(0, 0, kh, kv)
        KeyCont.moving[index] = 1
    }
	
	with Player {
		if self.index == index {
			var dir = point_direction(x, y, mouse_x, mouse_y)
			
		    KeyCont.dir_fire[index] = dir
			
			KeyCont.dis_fire[index] = point_distance(0, 0, ldrx(1, dir), ldry(1, dir))
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
            return "JAN"
    }

    return "??"
}

#macro mouse_hover (collision_point(mouse_x, mouse_y, object_index, false, false) == id)

function mouse_ui_clicked() {
	return UberCont.opt_keyboard ? mouse_check_button_pressed(mb_left) : mouse_check_button_released(mb_left)
}

function keyboard_anykey() {
	return !keyboard_check(vk_alt) && keyboard_check_pressed(vk_anykey)
}

device_mouse_dbclick_enable(0)


function camera_set_pos(_x, _y) {
	view_xview = _x
	view_yview = _y
	
	camera_set_view_pos(view_camera, _x, _y)
}

mp_potential_settings(90, 5, 5, 0)

global.wep_no_assist = {}

global.wep_no_assist[$ "2"] = 1
global.wep_no_assist[$ "8"] = 1
global.wep_no_assist[$ "12"] = 1
global.wep_no_assist[$ "25"] = 1
global.wep_no_assist[$ "32"] = 1
global.wep_no_assist[$ "35"] = 1
global.wep_no_assist[$ "37"] = 1
global.wep_no_assist[$ "36"] = 1
global.wep_no_assist[$ "48"] = 1
global.wep_no_assist[$ "49"] = 1
global.wep_no_assist[$ "51"] = 1
global.wep_no_assist[$ "60"] = 1
global.wep_no_assist[$ "63"] = 1
global.wep_no_assist[$ "65"] = 1
global.wep_no_assist[$ "68"] = 1
global.wep_no_assist[$ "76"] = 1
global.wep_no_assist[$ "110"] = 1
global.wep_no_assist[$ "113"] = 1
global.wep_no_assist[$ "119"] = 1
global.wep_no_assist[$ "122"] = 1
global.wep_no_assist[$ "125"] = 1
global.wep_no_assist[$ "111"] = 1

#macro target_direction point_direction(x, y, target.x, target.y)

#macro crown_current GameCont.crown

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
#macro wep_beetle_blaster 126
#macro wep_bone 127
#macro wep_golden_frog_pistol 255


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

enum AchievID {
	_,
	
	 // Chars
	MELTING_UNLOCKED,
	EYES_UNLOCKED,
	PLANT_UNLOCKED,
	Y_V_UNLOCKED,
	STEROIDS_UNLOCKED,
	ROBOT_UNLOCKED,
	CHICKEN_UNLOCKED,
	REBEL_UNLOCKED,
	HORROR_UNLOCKED,
	ROGUE_UNLOCKED,
	
	 // Skins
	FISH_BSKIN,
	CRYSTAL_BSKIN,
	MELTING_BSKIN,
	EYES_BSKIN,
	Y_V_BSKIN,
	STEROIDS_BSKIN,
	ROBOT_BSKIN,
	CHICKEN_BSKIN,
	REBEL_BSKIN,
	HORROR_BSKIN,
	ROGUE_BSKIN,
	
	 // Progress activities
	CROWN_LIFE,
	ULTRA_TIME,
	GOOD_FIND,
	GOOD_RIDDANCE,
	UNSTOPPABLE,
	FROG_ZONE,
	IMPOSSIBLE,
	SINCERE_APPOLOGIES,
	
	 // Bosses
	BOSS_BANDIT,
	BOSS_BIGDOG,
	BOSS_HUNTER,
	BOSS_THRONE,
	BOSS_THRONE2,
	BOSS_FROG,
	BOSS_CRYSTAL,
	BOSS_TECHNOMANCER,
	
	 // Gaming
	VAULT_RAIDER,
	GO_HARD,
	NOT_BAD,
	GAME_LOOPED,
	BOSS_CAPTAIN,
	ULTRA_MUTANT
}