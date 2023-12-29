#macro game_directory global.gamepath

global.desktop = ((os_type == os_windows) or (os_type == os_linux) or (os_type == os_macosx))

if global.desktop
	window_set_cursor(cr_none)

firstry = false

if IsVersionR() {
	if android_check_any_local_files() && !file_exists(".permissionlock")
		firstry = true
}
else if !android_check_storage_permission()
    firstry = true


alarm[0] = 1

loading = 0
cont = undefined

pos = 0
posy = 8

skills = -1
player = -1

disclaimer = 0

c = -1
b = -1

if file_exists("gamestate.dat") {
    loading = 1
}

game_directory = "/files/"

message = -1

date_set_timezone(timezone_utc)
