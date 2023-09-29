#macro game_directory global.gamepath

global.desktop = ((os_type == os_windows) or (os_type == os_linux))

if global.desktop
	window_set_cursor(cr_none)


firstry = 0

if os_check_permission("android.permission.WRITE_EXTERNAL_STORAGE") != os_permission_granted { //!file_exists("permcheck") {
    firstry = 1
}

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

alarm[0] = 1

game_directory = "/files/"

message = -1

date_set_timezone(timezone_utc)