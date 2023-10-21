#macro GAME_VERSION "b2.6.1"
#macro GAME_BUILD 2613
#macro BETA true


opt_fulscrn = 1
opt_fitscrn = 1
opt_mousecp = 1
opt_bksides = 0

//show_debug_overlay(1)

font = fntM1
big_font = fntBig

draw_set_font(font)


global.string_split_list = ds_list_create()
pauseimg = -1

//VERSION STUFF ETC.
version = GAME_VERSION

public = !global.desktop

//DEBUG STUFF
scrn = 0
scrn_take = 0

//DEFAULT STUFF
race = 0
paused = false
want_pause = false
quit_pause = false
alarm[0] = 30

scrLoadLocalizations()

saving = 0
saving_index = 0

mainsound = audio_emitter_create()
mainvol = 1

audio_emitter_falloff(mainsound, 100, 300, 1)

if !is_struct(playerinstance)
	playerinstance = new PlayerInstance()

scrInit()

scrWeapons()

tot_time = save_get_value("data", "tot_time", 0)
checksettings = save_get_value("etc", "checksettings", 0)
tot_time = save_get_value("data", "tot_time", 0)

xmas = 0
halloween = 0
april_fools = 0
birthday = 0

ideal_width = view_width
ideal_height = 240

max_view_width = round(240 * (display_get_width() / display_get_height()))

//set view size
scrSetViewSize()

cgot[0] = 1

draw_unlock = 0
unlock_text = ""

current_dt = date_current_datetime()

date_day = date_get_day(current_dt)
date_month = date_get_month(current_dt)
date_year = date_get_year(current_dt)

if date_day == 1 && date_month == 4 {
    april_fools = 1
}

if date_day >= 27 && date_month == 12 {
    xmas = 1
}

if date_day >= 30 && date_month == 10 {
    halloween = 1
}

if date_day == 7 && date_month == 8 {
    birthday = 1
}


//daily
namereq = -1

daily_run = 0
weekly_run = 0
daily_grill = false
weekly_grill = false
daily_time = 0
weekly_data = undefined
get_daily_times = 0

daily_seed = -1
daily_request = -1
weekly_request = -1

can_daily = false
can_weekly = false

leaderboards_allowed = false

splat_index = 0

pausespr = -1

global.coop = 0
global.is_server = 0

device_mouse_dbclick_enable(0) //os_type == os_android)

hp = 1
global.hardmode = 0

dont_save = 0

want_restart = 0
want_menu = 0
want_menu2 = 0
show_results = 0

global.lis_walls_visible = ds_list_create()
global.floor_screen = ds_list_create()

boss = 0
bossintro = 0
bossnamex = 0
bossx = 0
insound = 0
outsound = 0

if cgot[3] scrAchievement(0)
if cgot[4] scrAchievement(1)
if cgot[5] scrAchievement(2)
if cgot[6] scrAchievement(3)
if cgot[7] scrAchievement(4)
if cgot[8] scrAchievement(5)
if cgot[9] scrAchievement(6)
if cgot[10] scrAchievement(7)
if cgot[11] scrAchievement(8)
if cgot[12] scrAchievement(9)
if cgot[14] scrAchievement(26)

if cskingot[1] scrAchievement(10)
if cskingot[2] scrAchievement(11)
if cskingot[3] scrAchievement(13)
if cskingot[4] scrAchievement(12)
if cskingot[5] scrAchievement(14)
if cskingot[6] scrAchievement(15)
if cskingot[7] scrAchievement(16)
if cskingot[8] scrAchievement(17)
if cskingot[9] scrAchievement(18)
if cskingot[10] scrAchievement(19)
if cskingot[11] scrAchievement(20)
if cskingot[12] scrAchievement(21)

var all_have_weps = 1

for (var i = 1; i <= 12; i++) {
    if cwep[i] == race_swep[i] {
        all_have_weps = false
    }

    if wep_gold[cwep[i]] {
        scrAchievement(24)
    }
	else all_have_weps = 0

    if cwep[i] == wep_golden_nuke_launcher or cwep[i] == wep_golden_disc_gun {
        scrAchievement(25)
    }
	
	if cbst_loop[i] >= 3 && !opt_cheats {
		opt_cheats = save_set_value("cheats", "unlocked", true)
	}
}

if all_have_weps scrAchievement(15)

if hardgot {
    scrAchievement(39)
}

gamepad_set_axis_deadzone(0, 0.1)

localcoop = 0
gamepad_sel = 0

if opt_updates {
	update_request = scrHttpGet("https://raw.githubusercontent.com/toarch7/torcherdev/main/ntmobile.json")
}
else update_request = -1

update_info = undefined
update_message = -1

audio_falloff_set_model(audio_falloff_linear_distance_clamped)

lastinputframe = 0
touch_duration = [0, 0, 0, 0]
volqueue = -1

global.time = 0

global.crownpick = 1

global.recontinues = 0

if os_type == os_android
	volqueue = ds_queue_create()

continued_run = 0

// USER RESOURCES
resourcepack_temp_cleanup()
load_resourcepacks()

show_crosshair = true


if MultiplayerConfig
	open_two_windows(true)