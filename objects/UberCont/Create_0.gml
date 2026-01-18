#macro GAME_VERSION "beta-3.0.0"
#macro GAME_BUILD 3001
#macro BETA true

global.string_split_list = ds_list_create()

version = GAME_VERSION
version_text_drawn = false
public = true

native_cursor_inst = -1

//DEFAULT STUFF
race = 0
paused = false
want_pause = false
quit_pause = false
pauseimg = -1
pause_portrait_anim = 0
block_input_frames = 0
block_input_fire = false
timer_last_time = current_time
alarm[0] = 30

// non-public when running through GameMaker IDE
if (GM_build_type == "run") public = false

saving = 0
saving_index = 0

mainsound = audio_emitter_create()
mainvol = 1

audio_emitter_falloff(mainsound, 100, 300, 1)

if (is_undefined(my_player)) scr_playerinstances_reset_all()

letterbox = 0
letterbox_frame = 0

coop = false
hardmode = false
custom = false
custom_options = undefined
custom_mode_slots = array_create(max_custom_mode_slots, undefined)
custom_mode_disclaimer = true
custom_mode_slot_index = 0
global.is_server = false

scrInit()

tot_time = save_get_value("data", "tot_time", 0)
checksettings = save_get_value("etc", "checksettings", 0)
tot_banditkills = save_get_value("data", "tot_banditkills", 0)

xmas = false
halloween = false
april_fools = false
birthday = false

scrSetViewSize()

draw_unlock = 0
unlock_text = ""

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

device_mouse_dbclick_enable(0)

dont_save = false

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
global.lis_floors_visible = ds_list_create()

boss = 0
bossintro = 0
bossnamex = 0
bossx = 0
insound = 0
outsound = 0

// check for potential achievement sync-up
scrUnlocksCharacterStats()

device_mouse_dbclick_enable(0)
//mp_potential_settings(90, 5, 5, 0)
gamepad_set_axis_deadzone(0, 0.1)

localcoop = 0
gamepad_sel = 0

update_request_since_last = -1
update_request = scrGameQueryUpdateVersion()
update_notified = false

update_info = undefined
update_message = -1
update_url = "https://toncho.itch.io/nuclear-throne-mobile"

audio_falloff_set_model(audio_falloff_linear_distance_clamped)

lastinputframe = 0
touch_duration = [0, 0, 0, 0]
volqueue = -1

current_frame = 0

global.crownpick = 1

global.recontinued_times = 0

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

test_framerate_uncapped = false
