#macro c_text_background make_colour_rgb(49, 41, 61)
#macro border_width 48
#macro MAX_PLAYERS 1
#macro c_gold make_colour_rgb(218, 208, 146)
#macro c_ultra make_color_rgb(68, 198, 22)
#macro c_mapred make_color_rgb(200, 43, 43)
#macro UPDATE_WALLS global.lisUpdateWalls
#macro view_width global.view_width_val
#macro view_height global.view_height_val
#macro view_xview UberCont.view_xview_val
#macro view_yview UberCont.view_yview_val
#macro col_unavailable global.col_unavailable_val

// Multiplayer player instance index
global.index = 0

globalvar lockstep_stop;
lockstep_stop = 0

col_unavailable = merge_color(c_gray, c_dkgray, 0.5)

view_width = 320
view_height = 240

global.pc_build = 0

global.view_width_max = view_width

function scrSetViewSize(windowresize = 1) {
    var aspect_ratio = display_get_width() / display_get_height()
    var s = UberCont.opt_scaling
    var w = 320
    var h = 240

    ideal_width = w
    ideal_height = h

    global.view_width_max = round(ideal_height * aspect_ratio)

    if UberCont.opt_resolution {
        ideal_width = global.view_width_max
    }

    if ideal_width < w ideal_width = w

    if ideal_width & 1 ideal_width++

    view_width = ideal_width
    view_height = ideal_height

    room_set_view(romInit, 0, true, 0, 0, ideal_width, ideal_height, 0, 0, ideal_width * s, ideal_height * s, 0, 0, 0, 0, noone);
    room_set_view(romGame, 0, true, 0, 0, ideal_width, ideal_height, 0, 0, ideal_width * s, ideal_height * s, 0, 0, 0, 0, noone);
    room_set_view_enabled(romGame, 1)

    camera_set_view_size(view_camera, ideal_width, ideal_height)
    surface_resize(application_surface, ideal_width * s, ideal_height * s)
    camera_set_view_border(view_camera, ideal_width * s, ideal_height * s)
    display_set_gui_size(view_width, view_height)

    room_set_width(romGame, view_width)
    room_set_height(romGame, view_height)

    if windowresize {
        window_set_size(view_width, view_height)
        window_set_min_width(view_width)
        window_set_min_height(view_height)
    }
}

global.coopenemylist = {}

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
	
    crosshair: [0, 0, 0, 0],

    players: 1
}

#macro TeamColor global.TeamColor_val
TeamColor = [make_color_rgb(196, 97, 255), make_color_rgb(17, 213, 113),
make_color_rgb(255, 41, 41), make_color_rgb(41, 149, 255)]

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

function scrCollectInputs() {
	var val = 0
	
	for(var i = 0; i < global.input_keys_list_length; i ++) {
		if KeyCont[$ global.input_keys_list[i]][global.index] {
			val |= power(2, i + 1)
		}
	}
	
	return val
}

#macro gpad global._gpad_key
gpad = {
    shoulderl: gp_shoulderl,
    shoulderlb: gp_shoulderlb,
    shoulderr: gp_shoulderr,
    shoulderrb: gp_shoulderrb,

    face1: gp_face1,
    face2: gp_face2,
    face3: gp_face3,
    face4: gp_face4,

    padd: gp_padd,
    padu: gp_padu,
    padl: gp_padl,
    padr: gp_padr,

    start: gp_start,
    select: gp_select
}

function scrGPadReset() {
    gpad = {
        shoulderl: gp_shoulderl,
        shoulderlb: gp_shoulderlb,
        shoulderr: gp_shoulderr,
        shoulderrb: gp_shoulderrb,

        face1: gp_face1,
        face2: gp_face2,
        face3: gp_face3,
        face4: gp_face4,

        padd: gp_padd,
        padu: gp_padu,
        padl: gp_padl,
        padr: gp_padr,

        start: gp_start,
        select: gp_select
    }
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

function scrGamepadGet() {
    if gamepad_button_check_pressed(0, gp_shoulderl) {
        return gp_shoulderl
    } else if gamepad_button_check_pressed(0, gp_shoulderr) {
        return gp_shoulderr
    } else if gamepad_button_check_pressed(0, gp_shoulderlb) {
        return gp_shoulderlb
    } else if gamepad_button_check_pressed(0, gp_shoulderrb) {
        return gp_shoulderrb
    } else if gamepad_button_check_pressed(0, gp_face1) {
        return gp_face1
    } else if gamepad_button_check_pressed(0, gp_face2) {
        return gp_face2
    } else if gamepad_button_check_pressed(0, gp_face3) {
        return gp_face3
    } else if gamepad_button_check_pressed(0, gp_face4) {
        return gp_face4
    } else if gamepad_button_check_pressed(0, gp_padd) {
        return gp_padd
    } else if gamepad_button_check_pressed(0, gp_padu) {
        return gp_padu
    } else if gamepad_button_check_pressed(0, gp_padr) {
        return gp_padr
    } else if gamepad_button_check_pressed(0, gp_padl) {
        return gp_padl
    } else if gamepad_button_check_pressed(0, gp_start) {
        return gp_start
    } else if gamepad_button_check_pressed(0, gp_select) {
        return gp_select
    } else if keyboard_check_pressed(vk_space) {
        return gp_face1
    }

    return -1
}

function scrSetGamepadInputs(index = 0) {
    var kh = gamepad_axis_value(0, gp_axislh)
    var kv = gamepad_axis_value(0, gp_axislv)

    KeyCont.moving[index] = 0

    if abs(kh) > 0.1 or abs(kv) > 0.1 {
        KeyCont.dir_move[index] = point_direction(0, 0, kh, kv)
        KeyCont.moving[index] = point_distance(0, 0, kh, kv)
    }

    KeyCont.hold_fire[index] = gamepad_button_check(0, gpad.shoulderr)
    KeyCont.press_fire[index] = gamepad_button_check_pressed(0, gpad.shoulderr)
    KeyCont.release_fire[index] = gamepad_button_check_released(0, gpad.shoulderr)

    KeyCont.hold_spec[index] = gamepad_button_check(0, gpad.shoulderl)
    KeyCont.press_spec[index] = gamepad_button_check_pressed(0, gpad.shoulderl)
    KeyCont.release_spec[index] = gamepad_button_check_released(0, gpad.shoulderl)

    KeyCont.hold_swap[index] = gamepad_button_check(0, gpad.face3) or gamepad_button_check(0, gp_shoulderrb)
    KeyCont.press_swap[index] = gamepad_button_check_pressed(0, gpad.face3) or gamepad_button_check_pressed(0, gp_shoulderrb)
    KeyCont.release_swap[index] = gamepad_button_check_released(0, gpad.face3) or gamepad_button_check_released(0, gp_shoulderrb)

    KeyCont.hold_pick[index] = gamepad_button_check(0, gpad.face1)
    KeyCont.press_pick[index] = gamepad_button_check_pressed(0, gpad.face1)
    KeyCont.release_pick[index] = gamepad_button_check_released(0, gpad.face1)

    KeyCont.hold_horn[index] = gamepad_button_check(0, gp_stickl)
    KeyCont.press_horn[index] = gamepad_button_check_pressed(0, gp_stickl)
    KeyCont.release_horn[index] = gamepad_button_check_released(0, gp_stickl)

    var kh = gamepad_axis_value(0, gp_axisrh)
    var kv = gamepad_axis_value(0, gp_axisrv)

    if abs(kh) > 0.1 or abs(kv) > 0.1 {
        KeyCont.dir_fire[index] = point_direction(0, 0, kh, kv)
    }
}

function scrSetKeyboardInputs(index = 0) {
    var kh = keyboard_check(ord("D")) - keyboard_check(ord("A"))
    var kv = keyboard_check(ord("S")) - keyboard_check(ord("W"))

    KeyCont.moving[index] = 0

    if kh != 0 or kv != 0 {
        KeyCont.dir_move[index] = point_direction(0, 0, kh, kv)
        KeyCont.moving[index] = 1
    }

    KeyCont.hold_fire[index] = mouse_check_button(mb_left)
    KeyCont.press_fire[index] = mouse_check_button_pressed(mb_left)
    KeyCont.release_fire[index] = mouse_check_button_released(mb_left)

    KeyCont.hold_spec[index] = mouse_check_button(mb_right) or(!global.console_active && keyboard_check(ord("R")))
    KeyCont.press_spec[index] = mouse_check_button_pressed(mb_right) or(!global.console_active && keyboard_check_pressed(ord("R")))
    KeyCont.release_spec[index] = mouse_check_button_released(mb_right) or(!global.console_active && keyboard_check_released(ord("R")))

    KeyCont.hold_swap[index] = keyboard_check(vk_space)
    KeyCont.press_swap[index] = keyboard_check_pressed(vk_space)
    KeyCont.release_swap[index] = keyboard_check_released(vk_space)

    KeyCont.hold_pick[index] = keyboard_check(ord("E"))
    KeyCont.press_pick[index] = keyboard_check_pressed(ord("E"))
    KeyCont.release_pick[index] = keyboard_check_released(ord("E"))

    KeyCont.hold_horn[index] = keyboard_check(ord("B"))
    KeyCont.press_horn[index] = keyboard_check_pressed(ord("B"))
    KeyCont.release_horn[index] = keyboard_check_released(ord("B"))

    if global.console_active {
        KeyCont.press_paus[index] = 0
        KeyCont.press_horn[index] = 0
        KeyCont.press_pick[index] = 0
        KeyCont.press_swap[index] = 0
        KeyCont.moving[index] = 0
    }

    with Player
    if self.index == index {
        KeyCont.dir_fire[index] = point_direction(x, y, mouse_x, mouse_y)
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


device_mouse_dbclick_enable(0)

mp_potential_settings(90, 5, 5, 0)

global.AimAsistBlacklist = {}

global.AimAsistBlacklist[$ "2"] = 1
global.AimAsistBlacklist[$ "8"] = 1
global.AimAsistBlacklist[$ "12"] = 1
global.AimAsistBlacklist[$ "25"] = 1
global.AimAsistBlacklist[$ "32"] = 1
global.AimAsistBlacklist[$ "35"] = 1
global.AimAsistBlacklist[$ "37"] = 1
global.AimAsistBlacklist[$ "36"] = 1
global.AimAsistBlacklist[$ "48"] = 1
global.AimAsistBlacklist[$ "49"] = 1
global.AimAsistBlacklist[$ "51"] = 1
global.AimAsistBlacklist[$ "60"] = 1
global.AimAsistBlacklist[$ "63"] = 1
global.AimAsistBlacklist[$ "65"] = 1
global.AimAsistBlacklist[$ "68"] = 1
global.AimAsistBlacklist[$ "76"] = 1
global.AimAsistBlacklist[$ "110"] = 1
global.AimAsistBlacklist[$ "113"] = 1
global.AimAsistBlacklist[$ "119"] = 1
global.AimAsistBlacklist[$ "122"] = 1
global.AimAsistBlacklist[$ "125"] = 1
global.AimAsistBlacklist[$ "111"] = 1

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