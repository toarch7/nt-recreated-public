if instance_exists(UberCont) {
    with UberCont
		scrSetViewSize()
	
    instance_destroy()
    room_goto(romGame)
	
    exit
}

var check = false

if os_type == os_android {
    check = android_check_storage_permission()
	
    //if check == os_permission_denied or request_perm {
	if request_perm {
		var str = "The game needs access to read and write files for customization and saving progress." +
				  "\nIt is not strictly necessary if you're a regular player - you can deny or revoke this permission" +
				  "in the System Preferences in case if you experience problems with your game data."
		
		if (legacy) {
			str = "The game needs access to read and write files for customization and saving progress." +
			      "\nHowever, this permission is only necessary for importing your old progress, so you" +
			      "can revoke it once your data is confirmed safe."
		}
		
		message = show_message_async(loc(str))
		
        request_perm = false
        alarm[0] = -1

        exit
    }
}

if (alarm[0] > 0) exit

if os_type == os_android && check {
    game_directory = "/sdcard/games/com.toncho.nuclearthrone/files/"

    if !directory_exists(game_directory) {
        directory_create(game_directory)
    }
}
else {
	game_directory = string_replace_all(game_save_id, "//", "/")
}

my_player = undefined

with (instance_create(0, 0, UberCont)) {
	scrInitPostGamestart()
}

//
var info = os_get_info(), udid;
if (!ds_map_empty(info)) {
	udid = scrGenerateUID(info[? "udid"])
	save_set_value("general", "uid", udid)
}
ds_map_destroy(info)

//
randomize()

if (!loading) {
	if save_get_value("etc", "disclaimer", false) {
		room_goto(romGame)
	}
	else {
		disclaimer = true
	}
	exit
}

scrVolume()

try {
	instance_create(0, 0, GameCont)
	instance_create(0, 0, SpiralCont)
	instance_create(0, 0, TopCont)
	
	scrSavegameLoad()
	
	scrLetterbox(true)
    
	depth = UberCont.depth - 1
}
catch(e) {
	print_exception($"Failed to write game save.", e)
	event_user(0)
}