/// @description Define options

resourcepack_disclaimer_message = "RESOURCEPACKS ARE AN EXCLUSIVE FEATURE OF#NUCLEAR THRONE MOBILE.##A RESOURCEPACK IS A USER-CREATED ASSET COLLECTION (TEXTURES, SOUNDS, TEXT) FOR DECORATIVE PURPOSES ONLY, WITH NO GAMEPLAY BENEFITS.##RESOURCEPACK BROWSER, DESPITE BEING MODERATED,#MAY STILL CONTAIN QUESTIONABLE CONTENT.##THE DEVELOPER IS NOT LIABLE FOR ANY HARMFUL MATERIAL."
/// @loc:token [ResourcepackOptions] DisclaimerText "RESOURCEPACKS ARE AN EXCLUSIVE FEATURE OF#NUCLEAR THRONE MOBILE.##A RESOURCEPACK IS A USER-CREATED ASSET COLLECTION (TEXTURES, SOUNDS, TEXT) FOR DECORATIVE PURPOSES ONLY, WITH NO GAMEPLAY BENEFITS.##RESOURCEPACK BROWSER, DESPITE BEING MODERATED,#MAY STILL CONTAIN QUESTIONABLE CONTENT.##THE DEVELOPER IS NOT LIABLE FOR ANY HARMFUL MATERIAL."
resourcepack_disclaimer_message = string_insert_wordwraps(string_hash_to_newline(loc("ResourcepackOptions:DisclaimerText", resourcepack_disclaimer_message)), game_screen_width)

#region define categories

#region Main

var L = LF("Options")
scrOptionsMenuCategoryBegin(OptionCategory.Main)

scrOptionsMenuCreateElements
(
	{ type: "category", name: L("AudioOptions", "AUDIO"),      category: OptionCategory.Audio,    sprite: [ sprOptionsButtons, 0 ] },
	{ type: "category", name: L("VideoOptions", "VIDEO"),      category: OptionCategory.Video,    sprite: [ sprOptionsButtons, 1 ] },
	{ type: "category", name: L("GameOptions", "GAME"),        category: OptionCategory.Game,     sprite: [ sprOptionsButtons, 2 ] },
	{ type: "category", name: L("ControlOptions", "CONTROLS"), category: OptionCategory.Controls, sprite: [ sprOptionsButtons, 3 ] },
	{ type: "category", name: L("LANGUAGE", "LANGUAGE"),       category: OptionCategory.Language },
	
	{
		/// @loc:token [ResourcepackOptions] ResourcepackOptions "RESOURCEPACKS"
		type: "button", name: loc("ResourcepackOptions:ResourcepackOptions", "RESOURCEPACKS"), ingame: false,
		
		click: function() {
			scrOptionsMenuChangeCategory(OptionCategory.Resourcepacks)
			
			if (!save_get_value("etc", "resourcepack_disclaimer", false)) {
				resourcepack_disclaimer = true
			}
		}
	},
	
	/// @loc:token [Options] CheatOptions "CHEATS"
	{ type: "button", name: L("CheatOptions", "CHEATS"), ingame: false,
		click: function() {
			scrOptionsMenuChangeCategory(OptionCategory.Cheats)
		},
		awake: function(_opt) {
			_opt.visible = UberCont.opt_cheats
		}
	},
	
	{ type: "category", name: loc("CustomMode:Header", "CUSTOM"), category: OptionCategory.CustomMode, visible: false },
	
	{ type: "category", name: L("DisplayOptions", "DISPLAY"), category: OptionCategory.Video_Display, visible: false },
	
	{ type: "category", name: L("ProfileOptions", "PROFILE"), category: OptionCategory.Game_Profile,  visible: false },
	{ type: "category", name: L("ColorOptions", "COLOR"), category: OptionCategory.Game_Color,    visible: false },
	{ type: "category", name: L("DataOptions", "DATA"), category: OptionCategory.Game_Data,     visible: false },
	
	/// @loc:note [Options] Touch controls
	/// @loc:token [Options] TouchRemappingOptions "REMAPPING"
	{ type: "category", name: L("TouchRemappingOptions", "REMAPPING"), category: OptionCategory.Controls_Remapping, visible: false },
	/// @loc:note [Options] Keyboard/gamepad controls
	/// @loc:token [Options] KeyRemappingOptions "REMAPPING"
	{ type: "category", name: L("KeyRemappingOptions", "REMAPPING"), category: OptionCategory.Controls_Remapping_Keys, visible: false },
	{ type: "category", name: L("CharacterPrefOptions", "CHAR PREFS"), category: OptionCategory.Controls_Preferences, visible: false },
	{ type: "category", name: L("ExperimentalOptions", "EXPERIMENTAL OPTIONS"), category: OptionCategory.Controls_Experimental, visible: false },
	
	{ type: "category", name: L("CoopOptions", "CO-OP"), category: OptionCategory.Coop_Menu, visible: false },
	
	{ type: "category", name: loc("CustomMode:Loadout", "LOADOUT"), category: OptionCategory.CustomMode_Loadout, visible: false },
	{ type: "category", name: loc("CustomMode:Generation", "GENERATION"), category: OptionCategory.CustomMode_Generation, visible: false },
	{ type: "category", name: loc("CustomMode:Difficulty", "DIFFICULTY"), category: OptionCategory.CustomMode_Difficulty, visible: false },
	{ type: "category", name: loc("CustomMode:Other", "OTHER"), category: OptionCategory.CustomMode_Other, visible: false },
	{ type: "category", name: loc("CustomMode:Reset", "RESET"), category: OptionCategory.CustomMode_Reset, visible: false },
	
	{ type: "category", name: loc("CustomMode.Setup:Primary weapon", "PRIMARY WEAPON"), category: OptionCategory.CustomMode_WeaponSelector, visible: false,
		get_name: function(_opt) {
			with (CustomModeWeaponSelector) {
				if (choosing_secondary) {
					return loc("CustomMode.Setup:Secondary weapon", "SECONDARY WEAPON")
				}
			}
			
			return _opt.name
		}
	},
	{ type: "category", name: loc("CustomMode.Setup:PickMutations", "STARTING MUTATIONS"), category: OptionCategory.CustomMode_SkillSelector, visible: false },
	
)

scrOptionsMenuCategoryEnd()

#endregion
#region Audio

scrOptionsMenuCategoryBegin(OptionCategory.Audio)

L = LF("AudioOptions")
scrOptionsMenuCreateElements(
	{ type: "slider",  name: L("MasterVolume", "MASTER VOLUME"),     key: "volume_master"       },
	{ type: "slider",  name: L("MusicVolume", "MUSIC VOLUME"),       key: "volume_music"        },
	{ type: "slider",  name: L("AmbienceVolume", "AMBIENCE VOLUME"), key: "volume_ambient"      },
	/// @loc:token [AudioOptions] SoundsVolume "EFFECTS VOLUME"
	{ type: "slider",  name: L("SoundsVolume", "EFFECTS VOLUME"),    key: "volume_sfx"          },
	{ type: "switch",  name: L("3dSound", "3D SOUND"),               key: "volume_3dsound"      }
)

#endregion
#region Video

L = LF("VideoOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Video)

scrOptionsMenuCreateElements(
	/// @loc:token [VideoOptions] WideScreen "WIDESCREEN"
	{ type: "switch", name: L("WideScreen", "WIDESCREEN"), key: "visual_resolution", mobile_only: true },
	
	{
		type: "list", name: L("Crosshair", "CROSSHAIR"), key: "options_crosshair",
		list: range(0, sprite_get_number(sprCrosshair) - 1),
		
		draw: function(_opt) {
			draw_sprite(sprCrosshair, _opt.value, drawx + 90, drawy)
		},
		
		get_value: function(_opt) {
			return _opt.value + 1
		}
	},
	
	{
		type: "list", name: L("SideArt", "SIDE ART"), key: "options_sideart",
		list: range(0, sprite_get_number(sprSideArt) - 1),
		
		condition: function() {
			return !UberCont.opt_resolution
		},
		
		get_value: function(_opt) {
			if (_opt.value == 0) {
				return loc("VideoOptions:SideName:0", "NONE")
			}
			
			option_list_max --
			
			return loc_fmt_either(
				$"VideoOptions:SideName:{_opt.value}", "VideoOptions:SideName",
					"%1/%2", _opt.value, option_list_max)
		}
	},
	
	{ type: "slider",  name: L("Screenshake", "SCREENSHAKE"),    key: "visual_screenshake"  },
	{ type: "slider",  name: L("FreezeFrames", "FREEZE FRAMES"), key: "visual_freezeframes" },
	
	/// @loc:token [VideoOptions] Bloom "BLOOM"
	{ type: "switch",  name: L("Bloom", "BLOOM"),         key: "visual_bloom"        },
	/// @loc:token [VideoOptions] Particles "PARTICLES"
	{ type: "switch",  name: L("Particles", "PARTICLES"), key: "visual_particles",   states: [ OPTION_ON, OPTION_OFF ] },
	{ type: "switch",  name: L("HideHUD", "HIDE HUD"),    key: "visual_hud",         states: [ OPTION_ON, OPTION_OFF ] },
	
	{
		type: "list", name: L("PixelMode", "PIXEL MODE"), key: "visual_scaling", list: range(1, 4),
		draw: function(_opt) {
			var _dx = view_xview + drawx + 90,
				_dy = view_yview + drawy
			
			if (!instance_exists(debris)) {
				debris = instance_create(_dx, _dy, Debris)
			}
			
			with debris {
				x = _dx
				y = _dy
				mask_index = mskNone
				image_index = 0
				alarm[1] = 1
				alarm[0] = 2
				speed = 0
			}
		}
	},
	
	/// @loc:token [VideoOptions] DisplayOptions "DISPLAY SETTINGS"
	{ type: "category", name: L("DisplayOptions", "DISPLAY SETTINGS"), category: OptionCategory.Video_Display, desktop_only: true }
)

#endregion
#region Video_Display

L = LF("VideoOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Video_Display)

scrOptionsMenuCreateElements(
	/// @loc:token [VideoOptions] WideScreen "WIDESCREEN"
	{ type: "switch",  name: L("WideScreen", "WIDESCREEN"), key: "visual_resolution"   },
	{ type: "switch",  name: L("Fullscreen", "FULLSCREEN"), key: "options_fullscreen",
		click: function (_opt) {
			_opt.value = !window_get_fullscreen()
			scr_window_set_fullscreen(_opt.value)
			
			scrSetViewSize(true)
			
		},
		
		get_value: function(_opt) {
			return window_get_fullscreen()
		}
	},
	{ type: "switch",  name: L("Vsync", "VSYNC"), key: "options_vsync",
		click: function(_opt) {
			display_reset(0, _opt.value)
			scrBignameSurfaceCleanup()
		}
	}
)

#endregion
#region Game

L = LF("GameOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Game)

scrOptionsMenuCreateElements(
	{ type: "switch", name: L("BossIntros", "BOSS INTROS"), key: "visual_bossintro" },
	{ type: "switch", name: L("PlayTutorial", "PLAY TUTORIAL"), key: "game_tutorial", ingame: false },
	{ type: "switch", name: L("Timer", "SHOW TIMER"), key: "visual_timer" },
	{ type: "switch", name: L("Area", "SHOW AREA"), key: "visual_area" },
	//{
	/// @loc:token [GameOptions] NativeCursor "NATIVE CURSOR"
	//	type: "switch", name: "CURSOR", desktop_only: true, key: "options_cursor",
		
	//	condition: function(_opt) {
	//		return native_cursor_dll_status
	//	}
	//},
	
	/// @loc:token [GameOptions] MouseLock "MOUSELOCK"
	//{ type: "switch",   name: "MOUSELOCK",          key: "options_mouselock", desktop_only: true },
	
	/// @loc:token [GameOptions] PauseButton "PAUSE BUTTON"
	{ type: "switch",   name: L("PauseButton", "PAUSE BUTTON"), key: "options_pausebutton", mobile_only: true },
	
	/// @loc:token [GameOptions] AchievementPopups "ACHIEVEMENT#POPUPS"
	{ type: "switch",   name: L("AchievementPopups", "ACHIEVEMENT#POPUPS"), key: "options_achievements" },
	
	{ type: "switch",   name: L("AutoPause", "AUTO PAUSE"), key: "options_autopause", desktop_only: true },
	
	{
		type: "button", name: L("ViewCredits", "VIEW CREDITS"), ingame: false,
		
		click: function(_opt) {
			instance_create(0, 0, Credits)
			snd_play(sndMenuCredits)
			
			instance_destroy()
		}
	},
	
	/// @loc:token [GameOptions] ProfileOptions "PROFILE"
	{ type: "category", name: L("ProfileOptions", "PROFILE"), category: OptionCategory.Game_Profile }
)

#endregion
#region Game_Color

L = LF("ProfileOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Game_Color)

scrOptionsMenuCreateElements(
	{
		/// @loc:token [ProfileOptions] ColorHEX "EDIT HEX"
		type: "input", name: L("ColorHEX", "EDIT HEX"), key: undefined, halign: fa_left,
		
		draw: function(_opt) {
			var xx = gui_w / 2,
				yy = 64 + _opt.anim,
				
				w = 72 + _opt.anim,
				h = 6,
				
				/// @loc:token [ProfileOptions] ColorSelectorNone "NONE"
				val = loc("ProfileOptions", "ColorSelectorNone", "NONE")
			
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
			draw_text_nt(xx, yy + 1, val)
			
			draw_set_halign(_opt.halign)
			draw_set_valign(_opt.valign)
			
			return false
		},
		
		awake: function(_opt) {
			_opt.value = _opt.get_value(_opt)
			_opt.previous = _opt.value
			
			colorpicker_update_scales(global.player_color)
		},
		
		get_value: function(_opt) {
			return UberCont.opt_color
		},
		
		validate: function(_opt, str, confirm) {
			str = string(str)
			
			option_can_change = false
			
			if string_length(str) > 6 {
				_opt.previous = string_delete(str, 7, string_length(str) - 6)
				_opt.value = _opt.previous
				
				return true
			}
			
			if (confirm && string_length(str) % 2 != 0)
				return true
			
			if confirm
				_opt.value = base_convert(str, 16, 10)
			
			str = string_upper(str)
			
			for(var i = 1; i <= string_length(str); i ++) {
				var o = string_ord_at(str, i)
				
				if (o >= ord("A") && o <= ord("F")) or (o >= ord("0") && o <= ord("9"))
					continue
				
				return true
			}
			
			if confirm {
				colorpicker_update_scales(_opt.value)
				colorpicker_update_options(_opt.value)
			}
		}
	},
	
	{
		/// @loc:token [ProfileOptions] ColorRed "RED"
		type: "slider", name: L("ColorRed", "RED"), value: 0, key: "options_color",
		click: function(_opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				_opt.value * 255,
				color_get_green(col),
				color_get_blue(col)
			))
		}
	},
	
	{
		/// @loc:token [ProfileOptions] ColorGreen "GREEN"
		type: "slider", name: L("ColorGreen", "GREEN"), value: 0, key: "options_color",
		click: function(_opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				color_get_red(col),
				_opt.value * 255,
				color_get_blue(col)
			))
		}
	},
	
	{
		/// @loc:token [ProfileOptions] ColorBlue "BLUE"
		type: "slider", name: L("ColorBlue", "BLUE"), value: 0, key: "options_color",
		click: function(_opt) {
			var col = global.player_color
			
			option_can_change = false
			
			colorpicker_update_options(make_color_rgb(
				color_get_red(col),
				color_get_green(col),
				_opt.value * 255
			))
		}
	},
)

#endregion
#region Game_Profile

L = LF("ProfileOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Game_Profile)

scrOptionsMenuCreateElements(
	/// @loc:token [ProfileOptions] ID "ID"
	{ type: "button", name: L("ID", "ID"), key: "general_uid",
		get_value: function(_opt) {
			var value = scrSavedatascrGetUID(),
				copied = _opt[$ "__copied"]
			
			if copied == undefined {
				if is_string(value) && string_length(value) >= 8
					return string_copy(value, 1, 5) + "..."
			}
			
			if copied - current_frame > 0 {
				/// @loc:token [ProfileOptions] IDCopied "@g[COPIED]"
				return loc("ProfileOptions:IDCopied", "@g[COPIED]")
			}
			
			return value
		},
		
		click: function(_opt) {
			_opt.value = scrSavedatascrGetUID()
			
			if is_desktop {
				clipboard_set_text(_opt.value)
			}
			else if os_type == os_android {
				SetClipboard(_opt.value)
			}
			else return;
			
			_opt[$ "__copied"] = current_frame + 15
		}
	},
	
	/// @loc:token [ProfileOptions] ProfileName "PROFILE NAME"
	{ type: "input", name: L("ProfileName", "PROFILE NAME"), key: "etc_name", ingame: false,
		validate: function(_opt, str, confirm) {
			return scrValidateUsername(_opt, str, confirm)
		},
		
		get_name: function(_opt) {
			return text_input_element == _opt
				/// @loc:token [ProfileOptions] ProfileNameInput "ENTER PROFILE NAME"
				? loc("ProfileOptions:ProfileNameInput", "ENTER PROFILE NAME") : _opt.name
		}
	},
	
	/// @loc:token [ProfileOptions] ColorOptions "COLOR"
	{ type: "button", name: L("ColorOptions", "COLOR"), key: "options_color", ingame: false,
		click: function () {
			option_can_change = false
			scrOptionsMenuChangeCategory(OptionCategory.Game_Color)
		},
		
		get_value: function(_opt) {
			if !global.player_color {
				/// @loc:token [ProfileOptions] ColorDefault "DEFAULT"
				return loc("ProfileOptions:ColorDefault", "DEFAULT")
			}
			
			draw_set_color(global.player_color)
			
			return "[" + string(UberCont.opt_color) + "]"
		}
	},
	
	{
		/// @loc:token [ProfileOptions] DataOptions "DATA"
		type: "category", name: loc("Options:DataOptions", "DATA"), category: OptionCategory.Game_Data, ingame: false,
		
		awake: function(_opt) {
			if instance_exists(NicknameInput)
				_opt.visible = false
		}
	},
)

#endregion
#region Game_Data

L = LF("DataOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Game_Data)

scrOptionsMenuCreateElements(
	/// @loc:token [DataOptions] OptionsReset "RESET OPTIONS"
	{
		type: "button", name: L("OptionsReset", "RESET OPTIONS"),
		
		click: function() {
			disclaimer_pop = 1
			erasing_progress = 2
		}
	},
	
	/// @loc:token [DataOptions] ProgressReset "ERASE PROGRESS"
	{
		type: "button", name: L("ProgressReset", "ERASE PROGRESS"), ingame: false,
		
		click: function() {
			disclaimer_pop = 1
			erasing_progress = 1
		}
	},
)

#endregion
#region Controls

L = LF("ControlOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Controls)

scrOptionsMenuCreateElements(
	/// @loc:token [ControlOptions] GamepadOn "GAMEPAD"
	{ type: "switch", name: L("GamepadOn", "GAMEPAD"), key: "options_gamepad" },
	
	/// @loc:token [ControlOptions] GamepadStyle "GAMEPAD STYLE"
	{ type: "list", name: L("GamepadStyle", "GAMEPAD STYLE"), key: "options_gamepad_type", list: range(0, array_length(gamepad_types) - 1),
		condition: function() {
			return is_gamepad(global.index)
		},
		
		draw: function() {
			if option_selected && sprite_exists(gamepad_icon_small) {
				for(var i = 0; i < 4; i ++) {
					draw_sprite(gamepad_icon_small, i, (gui_w / 2 - 32) + i * 16, startdrawy - 16)
				}
			}
		},
		
		get_value: function(_opt) {
			var _type = gamepad_types[_opt.value]
			return (_type == "XBONE") ? "XBOX ONE" : _type
		}
	},
	
	/// @loc:token [ControlOptions] AimAssist "AIM ASSIST"
	{ type: "switch", name: L("AimAssist", "AIM ASSIST"),               key: "controls_assist",       mobile_only: true },
	/// @loc:token [ControlOptions] AutoAim "FULL AUTOAIM"
	{ type: "switch", name: L("AutoAim", "FULL AUTOAIM"),               key: "controls_aimbot",       mobile_only: true },
	/// @loc:note [ControlOptions] Allows swapping and using abilities by pressing volume buttons
	/// @loc:token [ControlOptions] VolumeControls "VOLUME CONTROLS"
	{ type: "switch", name: L("VolumeControls", "VOLUME CONTROLS"),     key: "options_volumecontrol", mobile_only: true },
	/// @loc:note [ControlOptions] Split aim & fire into two separate control elements
	/// @loc:token [ControlOptions] SplitFireControls "SPLIT AIM & FIRE"
	{ type: "switch", name: L("SplitFireControls", "SPLIT AIM & FIRE"), key: "controls_splitfire",    mobile_only: true,
		condition: function() {
			return !UberCont.opt_aimbot
		}
	},
	/// @loc:note [ControlOptions] Force player aim crosshair to be always visible
	/// @loc:token [ControlOptions] FixedSight "FIXED SIGHT"
	{ type: "switch", name: L("FixedSight", "FIXED SIGHT"),      key: "controls_fixsight",     mobile_only: true },
	
	/// @loc:token [ControlOptions] TouchControlScale "SIZE SCALE"
	{ type: "slider", name: L("TouchControlScale", "SIZE SCALE"), key: "controls_scale", mobile_only: true },
	
	/// @loc:token [ControlOptions] Remap "REMAP CONTROLS"
	{ type: "button", name: L("Remap", "REMAP CONTROLS"),
		get_name: function(_opt) {
			var str = _opt.name
			
			if is_gamepad() {
				return str + " " + loc("ControlOptions:RemapGamepad", "(GAMEPAD)")
			}
			
			if is_keyboard() && !is_desktop {
				return str + " " + loc("ControlOptions:RemapKeyboard", "(KEYBOARD)")
			}
			
			return str
		},
		
		click: function() {
			if is_gamepad() or is_keyboard() {
				scrOptionsMenuChangeCategory(OptionCategory.Controls_Remapping_Keys)
				
				exit
			}
			
			editing_mode = true
	        remap_pos = 0
			
	        if (!UberCont.opt_gamepad) scrCreateMobileControls()
			
			scrOptionsMenuChangeCategory(OptionCategory.Controls_Remapping, false)
		}
	},
	
	/// @loc:token [Options] CharacterPrefOptions "CHARACTER PREFERENCES"
	{ type: "category", name: loc("Options:CharacterPrefOptions", "CHARACTER PREFERENCES"), category: OptionCategory.Controls_Preferences, mobile_only: true },
	
	/// @loc:token [Options] ExperimentalOptions "EXPERIMENTAL OPTIONS"
	{ type: "category", name: loc("Options:ExperimentalOptions", "EXPERIMENTAL OPTIONS"), category: OptionCategory.Controls_Experimental, mobile_only: true }
)

scrOptionsMenuCategoryEnd()
#endregion Controls
#region Language
scrOptionsMenuCategoryBegin(OptionCategory.Language)

draw_set_font(fntM1)

array_foreach(languages, function(_language_key) {
	var _language_data = global.language_store[$ _language_key]
	
	if (is_undefined(_language_data)) exit
	
	var _language_name = _language_data[$ "Init:Name"],
		_language_label = _language_data[$ "Init:LabelSprite"]
	
	if (!is_string(_language_name)) {
		_language_name = string_upper(_language_key)
	}
	
	var _opt = {
		type: "button",
		name: _language_name,
		language: _language_key,
		click: function(_opt) {
			snd_play(sndClick)
			save_set_value("etc", "language", _opt.language)
			scrOptionsUpdate()
		}
	}
	
	if (sprite_exists(_language_label)) {
		_opt.sprite = [ _language_label, 0 ]
	}
	
	scrOptionsMenuCreateElement(_opt)
})

draw_reset_font()

scrOptionsMenuCategoryEnd()
#endregion Language
#region Controls_Remapping
scrOptionsMenuCategoryBegin(OptionCategory.Controls_Remapping)

scrOptionsMenuCreateElements(
	/// @loc:token [ControlOptions] ResetTouchLayout "RESET LAYOUT"
	{ type: "button", name: loc("ControlOptions", "ResetTouchLayout", "RESET LAYOUT"),
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
	
	/// @loc:token [ControlOptions] SimpleTouchControls "SIMPLIFY"
	{ type: "switch", name: loc("ControlOptions:SimpleTouchControls", "SIMPLIFY"), halign: fa_center, key: "visual_simplify", draw: draw_inline_switch }
)
#endregion Controls_Remapping
#region Controls_Remapping_Keys

L = LF("ControlOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Controls_Remapping_Keys)

condition_keyboard = function() { return (is_keyboard() && !is_gamepad()) }
condition_gamepad = function() { return is_gamepad() }

scrOptionsMenuCreateElements(
	/// @loc:token [ControlOptions] ButtonFire "FIRE"
	{ type: "keybind", name: L("ButtonFire", "FIRE"), key: "fire" },
	/// @loc:token [ControlOptions] ButtonActive "ACTIVE"
	{ type: "keybind", name: L("ButtonActive", "ACTIVE"), key: "spec" },
	/// @loc:token [ControlOptions] ButtonSwap "SWAP"
	{ type: "keybind", name: L("ButtonSwap", "SWAP"), key: "swap" },
	/// @loc:token [ControlOptions] ButtonPick "PICK/USE"
	{ type: "keybind", name: L("ButtonPick", "PICK/USE"), key: "pick" },
	
	/// @loc:token [ControlOptions] ButtonChat "CO-OP CHAT"
	{ type: "keybind", name: L("ButtonChat", "CO-OP CHAT"), key: "chat", condition: condition_keyboard },
	/// @loc:token [ControlOptions] ButtonUp "WALK UP"
	{ type: "keybind", name: L("ButtonUp", "WALK UP"), key: "north", condition: condition_keyboard },
	/// @loc:token [ControlOptions] ButtonDown "WALK DOWN"
	{ type: "keybind", name: L("ButtonDown", "WALK DOWN"), key: "south", condition: condition_keyboard },
	/// @loc:token [ControlOptions] ButtonLeft "WALK LEFT"
	{ type: "keybind", name: L("ButtonLeft", "WALK LEFT"), key: "west", condition: condition_keyboard },
	/// @loc:token [ControlOptions] ButtonRight "WALK RIGHT"
	{ type: "keybind", name: L("ButtonRight", "WALK RIGHT"), key: "east", condition: condition_keyboard },
	
	/// @loc:token [ControlOptions] DebugOverlay "DEBUG OVERLAY"
	{ type: "keybind", name: L("DebugOverlay", "DEBUG OVERLAY"), key: "console",
		awake: function(_opt) {
			_opt.visible = UberCont.opt_cheats || (ingame && !scr_debug_cheats_enabled())
		},
		
		condition: condition_keyboard
	},
	
	/// @loc:token [ControlOptions] ResetDefaults "DEFAULT PRESET"
	{ type: "button", name: L("ResetDefaults", "DEFAULT PRESET"),
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

L = LF("CharacterPrefOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Controls_Preferences)

cpref_condition = function(_opt) { return UberCont.ctot_time[_opt.char] > 0 }

cpref_name = function(_opt) {
	/// @loc:token [CharacterPrefOptions] CharacterLocked "LOCKED"
	return (!UberCont.ctot_time[_opt.char]) ? "@d- " + loc("CharacterPrefOptions:CharacterLocked", "LOCKED") + " -"
		: "@(sprMapIcon," + string(scr_race_get_skin_subimage(_opt.char, 0)) + ") " + _opt.name
}

scrOptionsMenuCreateElements(
	/// @loc:token [CharacterPrefOptions] AutoTelekinesis "AUTO TELEKINESIS"
	{ type: "switch", name: L("AutoTelekinesis", "AUTO TELEKINESIS"), key: "cprefs_eyes", char: Race.Eyes,
			condition: cpref_condition, get_name: cpref_name },
		
	/// @loc:token [CharacterPrefOptions] AutoExplosions "AUTO EXPLOSIONS"
	{ type: "switch", name: L("AutoExplosions", "AUTO EXPLOSIONS"), key: "cprefs_melting", char: Race.Melting,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] AutoSnare "AUTO SNARE"
	{ type: "switch", name: L("AutoSnare", "AUTO SNARE"), key: "cprefs_plant", char: Race.Plant,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] PopPopToggle "POP-POP TOGGLE"
	{ type: "switch", name: L("PopPopToggle", "POP-POP TOGGLE"), key: "cprefs_yv", char: Race.Venuz,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] DualWieldToggle "DUAL WIELD TOGGLE"
	{ type: "switch", name: L("DualWieldToggle", "DUAL WEILD TOGGLE"), key: "cprefs_steroids", char: Race.Steroids,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] UseWeaponWhenBeaming "USE WEAPON BEAMING"
	{ type: "switch", name: L("UseWeaponWhenBeaming", "USE WEAPON BEAMING"), key: "cprefs_horror", char: Race.Horror,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] SwipeBombing "SWIPE BOMBING"
	{ type: "switch", name: L("SwipeBombing", "SWIPE BOMBING"), key: "cprefs_rogue", char: Race.Rogue,
			condition: cpref_condition, get_name: cpref_name },
	
	/// @loc:token [CharacterPrefOptions] GambleToggle "GAMBLE TOGGLE"
	{ type: "switch", name: L("GambleToggle", "GAMBLE Toggle"), key: "cprefs_skeleton", char: Race.Skeleton,
			condition: cpref_condition, get_name: cpref_name },
)


#endregion Controls_Preferences
#region Controls_Experimental

L = LF("ExperimentalOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Controls_Experimental)

scrOptionsMenuCreateElements(
	/// @loc:token [ExperimentalOptions] KeyboardMode "KEYBOARD MODE"
	{ type: "switch", name: L("KeyboardMode", "KEYBOARD MODE"),    key: "options_keyboard" },
	
	/// @loc:token [ExperimentalOptions] JoystickRegions "STICK REGIONS"
	{ type: "switch", name: L("JoystickRegions", "STICK REGIONS"),    key: "controls_stickregions" },
	
	/// @loc:token [ExperimentalOptions] HideJoysticks "HIDE JOYSTICKS"
	{ type: "switch", name: L("HideJoysticks", "HIDE JOYSTICKS"),   key: "controls_hiddensticks",
		get_value: function(_opt) {
			if UberCont.opt_stickregions
				return true
			
			return _opt.value
		},
		
		condition: function(_opt) {
			return !UberCont.opt_stickregions
		}
	},
)

#endregion Controls_Experimental
#region Resourcepacks

L = LF("ResourcepackOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Resourcepacks)

scrOptionsMenuCreateElements(
	{
		/// @loc:token [ResourcepackOptions] ViewInstalled "VIEW INSTALLED"
		type: "button", name: L("ViewInstalled", "VIEW INSTALLED"), ingame: false,
		
		click: function() {
			with instance_create(0, 0, ResourcepackManager) {
				browsing = false
				event_user(0)
			}
		}
	},
	
	{
		/// @loc:token [ResourcepackOptions] Browse "BROWSE DOWNLOAD"
		type: "button", name: L("Browse", "BROWSE AND DOWNLOAD"), ingame: false,
		
		click: function() {
			with instance_create(0, 0, ResourcepackManager) {
				browsing = true
				event_user(0)
			}
		}
	},
	
	{
		/// @loc:token [ResourcepackOptions] DirectDownload "DIRECT DOWNLOAD"
		type: "input", name: L("DirectDownload", "DIRECT DOWNLOAD"), value: "",
		
		validate: function(_opt, str, confirm) {
			if confirm {
				var a = "https://github.com/"
				
				if string_starts_with(str, a)
					str = string_delete(str, 1, string_length(a))
				
				if string_char_at(str, string_length(str)) == "/"
					str = string_delete(str, string_length(str) - 1, 1)
				
				if string_count("/", str) != 1
					return true
				
				keyboard_string = ""
				_opt.value = ""
				
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

L = LF("CheatOptions")
scrOptionsMenuCategoryBegin(OptionCategory.Cheats)

scrOptionsMenuCreateElements(
	/// @loc:note [CheatOptions] Developer debug overlay
	/// @loc:token [CheatOptions] Console "CONSOLE"
	{ type: "switch", name: L("Console", "CONSOLE"), key: "cheats_console" },
	
	/// @loc:note [CheatOptions] Unlimited skill selection range
	/// @loc:token [CheatOptions] GrillerMode "GRILLER MODE"
	{ type: "switch", name: L("GrillerMode", "GRILLER MODE"), key: "cheats_griller" },
	
	/// @loc:note [CheatOptions] Player gets timed out for 45sec instead of dying
	/// @loc:token [CheatOptions] Practice "PRACTICE"
	{ type: "switch", name: L("Practice", "PRACTICE"), key: "cheats_practice" }
)

#endregion Cheats
#region Coop_Menu
scrOptionsMenuCategoryBegin(OptionCategory.Coop_Menu)

scrOptionsMenuCreateElements(
	/// @loc:token [Options] ProfileOptions "PROFILE"
	{ type: "category", name: loc("Options:ProfileOptions", "PROFILE"), category: OptionCategory.Game_Profile },
	
	{
		/// @loc:token [R:CoopLobby] Host "HOST GAME"
		type: "button", name: loc("R:CoopLobby:Host", "HOST GAME"),
		
		click: function() {
			
			if !instance_exists(CoopMenu) {
				with instance_create(0, 0, CoopMenu)
					menu = other.id
			}
			
			CoopMenu.host_game()
		}
	},
	
	{
		type: "button", name: loc("R:CoopLobby:Join", "JOIN DIRECT"),
		
		click: function() {
			
			if !instance_exists(CoopMenu) {
				with instance_create(0, 0, CoopMenu)
					menu = other.id
			}
			
			CoopMenu.join_remote(global.ip, global.port)
		}
	},
	
	/// @loc:token [R:CoopLobby] RemoteAddress "REMOTE ADDRESS"
	{ type: "input", name: loc("R:CoopLobby:RemoteAddress", "REMOTE ADDRESS"), key: "coop_lastip" },
	
	{
		/// @loc:token [R:CoopLobby] RemotePort "REMOTE PORT"
		type: "input", name: loc("R:CoopLobby:RemotePort", "REMOTE PORT"), key: "coop_lastport",
		
		validate: function(_opt, str, confirm) {
			if string_digits(str) != str or string_length(str) > 5
				return true
			
			if confirm && str == ""
				return true
		}
	},
	
	/// @loc:token [R:CoopLobby] RemoteAddress "REFRESH LOCAL GAMES"
	{ type: "button", name: loc("R:CoopLobby:RefreshLocal", "REFRESH LOCAL GAMES"),
		condition: function (_opt) {
			with CoopMenu {
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
			
			scrOptionsMenuRemoveLocalGames()
		}
	}
)

local_game_template = {
	type: "button", name: "???'s GAME",
	
	ip: UberCont.opt_remote_ip,
	port: UberCont.opt_remote_port,
	
	__multiplayer_game: true,
	
	click: function(_opt) {
		CoopMenu.join_remote(_opt.ip, _opt.port)
	},
	
	draw: function(_opt) {
		draw_set_color(option_selected ? #00a3e3 : #005f85)
		draw_text_nt(drawx, drawy, _opt.name)
		
		return true
	}
}

#endregion
#region CustomMode

L = LF("CustomMode")
scrOptionsMenuCategoryBegin(OptionCategory.CustomMode)

var _get_value_stub = function() {
	return ""
}
var _custom_mode_button_category = function(_opt) {
	print("Click category", _opt.category)
	scrOptionsMenuChangeCategory(_opt.category)
}

scrOptionsMenuCreateElements(
	{ type: "button", name: L("Start", "START"), halign: fa_left,
		click: function() {
			instance_destroy()
			instance_destroy(SpiralCont)
			instance_create(0, 0, GameCont)
			instance_create(0, 0, MenuGen)
			snd_play(sndMenuCharSelect)
		},
		get_value: _get_value_stub
	},
	
	{ type: "button", name: L("Slot", "SLOT"), halign: fa_left,
		click: function(_opt) {
			with (UberCont) {
				var _max_slots = array_length(custom_mode_slots)
				custom_mode_slot_index = (custom_mode_slot_index + 1) % _max_slots
				custom_options = custom_mode_slots[custom_mode_slot_index]
			}
			snd_play(sndClick)
		},
		get_value: function() {
			return $"{UberCont.custom_mode_slot_index + 1}/{array_length(UberCont.custom_mode_slots)}"
		}
	},
	
	{ type: "button", name: L("Loadout", "LOADOUT"),
			get_value: _get_value_stub, halign: fa_left,
			category: OptionCategory.CustomMode_Loadout,
			click: _custom_mode_button_category },
	
	{ type: "button", name: L("Generation", "GENERATION"),
			get_value: _get_value_stub, halign: fa_left,
			category: OptionCategory.CustomMode_Generation,
			click: _custom_mode_button_category },
	
	{ type: "button", name: L("Difficulty", "DIFFICULTY"),
			get_value: _get_value_stub, halign: fa_left,
			category: OptionCategory.CustomMode_Difficulty,
			click: _custom_mode_button_category },
	
	{ type: "button", name: L("Other", "OTHER"),
			get_value: _get_value_stub, halign: fa_left,
			category: OptionCategory.CustomMode_Other,
			click: _custom_mode_button_category },
	
	{ type: "button", name: L("Reset", "RESET SLOT TO DEFAULTS"),
			get_value: _get_value_stub, halign: fa_left,
			category: OptionCategory.CustomMode_Reset,
			click: _custom_mode_button_category },
)

#endregion
#region CustomMode_Lodout

L = LF("CustomMode.Setup")
scrOptionsMenuCategoryBegin(OptionCategory.CustomMode_Loadout)

scrOptionsMenuCreateElements(
	{ type: "button", name: L("Primary weapon", "PRIMARY WEAPON"),
		click: function() {
			instance_destroy(CustomModeMenu)
			instance_create(0, 0, CustomModeWeaponSelector)
			snd_play(sndClick)
		}
	},
	{ type: "button", name: L("Primary weapon", "PRIMARY WEAPON"),
		click: function() {
			instance_destroy(CustomModeMenu)
			with (instance_create(0, 0, CustomModeWeaponSelector)) {
				choosing_secondary = true
			}
			snd_play(sndClick)
		}
	},
	{ type: "button", name: loc("CustomMode.Extras:ProtoWep", "PROTO WEAPON"),
		click: function() {
			instance_destroy(CustomModeMenu)
			with (instance_create(0, 0, CustomModeWeaponSelector)) {
				choosing_proto = true
			}
			snd_play(sndClick)
		}
	},
	{ type: "button", name: L("PickMutataions", "STARTING MUTATIONS"),
		click: function() {
			instance_destroy(CustomModeMenu)
			instance_create(0, 0, CustomModeSkillSelector)
			snd_play(sndClick)
		}
	},
	{ type: "button", name: L("Mutation choices", "MUTATION CHOICES"),
		click: function() {
		}
	},
	{ type: "button", name: L("MaxLevel", "MAX LEVEL"),
		click: function() {
		}
	},
	{ type: "button", name: L("LevelCost", "LEVEL COST"),
		click: function() {
		}
	},
	{ type: "button", name: L("LevelUltra", "LEVEL ULTRA"),
		click: function() {
		}
	}
	
)

#endregion

scrOptionsMenuCategoryEnd()
#endregion
