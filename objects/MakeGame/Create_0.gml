globalvar game_directory;
game_directory = ""

legacy = false
request_perm = false

if android_check_storage_permission() == os_permission_denied {
	if IsVersionR() && android_check_any_local_files() {
		request_perm = true
		legacy = true
	}
}

scr_debug_overlay_load()

alarm[0] = 1

loading = 0
cont = undefined

pos = 0
posy = 8

skills = -1
player = -1

disclaimer = 0

gamestatebuffer_c = -1
gamestatebuffer = -1

if file_exists("gamestate.dat") {
    loading = 1
}

game_directory = "/files/"

message = -1

date_set_timezone(timezone_utc)

scrLanguagesLoad()

display_set_timing_method(tm_sleep)
display_set_sleep_margin(33)