#macro GAME_VERSION "beta-3.0.0"
#macro GAME_BUILD 3000
#macro BETA true

opt_fulscrn = 1
opt_fitscrn = 1
opt_mousecp = 1
opt_bksides = 0

native_cursor_inst = -1

//show_debug_overlay(1)

font = fntM1
big_font = fntBig

draw_set_font(font)
device_mouse_dbclick_enable(0)
mp_potential_settings(90, 5, 5, 0)

global.string_split_list = ds_list_create()

pauseimg = -1
version = GAME_VERSION
public = true

scrn = 0
scrn_take = 0

//DEFAULT STUFF
race = 0
paused = false
want_pause = false
quit_pause = false
alarm[0] = 30

saving = 0
saving_index = 0

mainsound = audio_emitter_create()
mainvol = 1

// non-public when running through GameMaker IDE
if GM_build_type == "run" {
	public = false
}

audio_emitter_falloff(mainsound, 100, 300, 1)

if is_undefined(my_player) scr_playerinstances_reset_all()

scrInit()

tot_time = save_get_value("data", "tot_time", 0)
checksettings = save_get_value("etc", "checksettings", 0)
tot_time = save_get_value("data", "tot_time", 0)

xmas = 0
halloween = 0
april_fools = 0
birthday = 0

scrSetViewSize()

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
thronebutt_api_failures = 0

daily_seed = -1
daily_request = -1
weekly_request = -1

can_daily = false
can_weekly = false

leaderboards_allowed = false

splatindex = 0

pausespr = -1

global.coop = 0
global.is_server = 0

device_mouse_dbclick_enable(0) //os_type == os_android)

hp = 1
global.hardmode = 0

dont_save = 0

// restart countdown variable
want_restart = 0
// quit to menu countdown variable
want_menu = 0
// quit to menu flag that tells the game to quit from the session
// for more detail see `Vlambeer - Create` event
want_quit_to_menu = false
// if the leaderboards needs be shown after the run's end
show_leaderboards_menu = false
// indicates if the shown leaderboard will be for weeklies
show_weekly_results_menu = false

global.lis_walls_visible = ds_list_create()
global.list_floors_visible = ds_list_create()

boss = 0
bossintro = 0
bossnamex = 0
bossx = 0
insound = 0
outsound = 0

// check for potential achievement sync-up
scrUnlocksCharacterStats()

gamepad_set_axis_deadzone(0, 0.1)

localcoop = 0
gamepad_sel = 0

if opt_updates {
	update_request = scrHttpGet("https://raw.githubusercontent.com/toarch7/torcherdev/main/ntmobile.json")
}
else update_request = -1

update_info = undefined
update_message = -1
update_url = "https://toncho.itch.io/nuclear-throne-mobile"

audio_falloff_set_model(audio_falloff_linear_distance_clamped)

lastinputframe = 0
touch_duration = [0, 0, 0, 0]
volqueue = -1

current_frame = 0

global.crownpick = 1

global.recontinues = 0

if os_type == os_android
	volqueue = ds_queue_create()

continued_run = 0

// USER RESOURCES
resourcepack_temp_cleanup()
load_resourcepacks()

show_crosshair = true

if is_steamdeck
	show_crosshair = false

if MultiplayerConfig
	scrWindowOpenSecondary(true)

global.seed = random_get_seed()